-- Corrections finales :
-- 1. Candidatures closes à la date limite ; plus d’offre ni de confirmation une fois
--    la mission commencée.
-- 2. Clôture du recrutement au début de la mission (settle_due) : candidatures en
--    attente refusées, offres expirées, places vides débloquées ; une mission sans
--    aucune affectation est annulée. Une mission est terminée quand toutes ses
--    affectations sont terminales et qu’au moins une est payée.
-- 3. Explorer : position de l’appareil (lat/lng facultatifs) pour le rayon.
-- 4. Pièce d’identité : message propre au selfie manquant.
--
-- Les droits sont conservés par « create or replace ». La nouvelle signature de
-- list_missions est accordée explicitement (la révocation par défaut de 000003 vaut
-- pour toute nouvelle fonction).

-- ---------------------------------------------------------------------------
-- Mission vue par son annonceur : « completed » ne dépend plus des places libres,
-- seulement du début de la mission (recrutement clos) et des affectations.
-- ---------------------------------------------------------------------------
create or replace function public.poster_mission_json(m public.missions) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'id', m.id,
    'title', m.title,
    'category', m.category,
    'city', m.city,
    'startAt', public.iso(m.start_at),
    'durationMin', m.duration_min,
    'payAmount', m.pay_amount,
    'payUnit', m.pay_unit,
    'slotsTotal', m.slots_total,
    'slotsConfirmed', s.confirmed,
    'slotsOffered', s.offered,
    'applicantsCount', s.applicants,
    'newApplicantsCount', s.fresh,
    'blockedAmount', coalesce((select b.amount from public.blocked_funds b where b.mission_id = m.id), 0),
    'status', case
      when m.status = 'cancelled' then 'cancelled'
      -- Recrutement clos (mission commencée) et toutes les affectations non annulées
      -- payées (donc terminales), au moins une.
      when m.start_at <= now() and s.confirmed > 0 and s.paid = s.confirmed then 'completed'
      when s.working > 0 then 'inProgress'
      when s.confirmed + s.offered > 0 then 'selected'
      else 'published' end)
  from (select
      (select count(*) from public.assignments y
        where y.mission_id = m.id and y.status <> 'cancelled')::int as confirmed,
      (select count(*) from public.assignments y
        where y.mission_id = m.id and y.status = 'paid')::int as paid,
      (select count(*) from public.assignments y
        where y.mission_id = m.id and y.status in ('in_progress', 'submitted', 'contested'))::int as working,
      (select count(*) from public.applications x
        where x.mission_id = m.id and x.status = 'offered')::int as offered,
      (select count(*) from public.applications x
        where x.mission_id = m.id and x.status <> 'withdrawn')::int as applicants,
      (select count(*) from public.applications x
        where x.mission_id = m.id and x.status = 'pending')::int as fresh) s
$$;

-- ---------------------------------------------------------------------------
-- Échéances
-- ---------------------------------------------------------------------------

-- Échéances (settle) : offres échues → expired ; affectations soumises dont
-- l’échéance est passée → versées ; mission commencée → recrutement clos.
-- Idempotente. N’attend jamais : une mission ou un portefeuille verrouillé par une
-- autre transaction est réglé au passage suivant. Une mission dont le règlement
-- échoue est ignorée (avertissement) ; la validation directe (validate_assignment)
-- lève, elle, l’erreur.
--
-- Clôture du recrutement (mission « published » dont le début est passé, ou mission
-- close dont une place s’est libérée depuis, par désistement) :
-- - candidatures en attente → rejected, offres en cours → expired ;
-- - sans aucune affectation non annulée : mission annulée, tout le montant bloqué
--   libéré ;
-- - sinon : mission « filled », le montant des places vides (places libres × montant
--   par place) libéré, places libres remises à zéro (ce qui rend la clôture
--   idempotente). Les affectations contestées gardent leur montant bloqué.
create or replace function public.settle_due() returns void
language plpgsql security definer set search_path = public as $$
declare
  mid text;
  m public.missions;
  aid text;
  pay_due boolean;
  close_due boolean;
  blocked integer;
  freed integer;
begin
  for mid in
    select x.mission_id from public.applications x
      where x.status = 'offered' and x.offer_expires_at <= now()
    union
    select y.mission_id from public.assignments y
      where y.status = 'submitted' and y.auto_validate_at <= now()
    union
    select z.id from public.missions z
      where z.start_at <= now()
        and (z.status = 'published' or (z.status = 'filled' and z.slots_free > 0))
    order by 1
  loop
    -- Chaque mission dans sa sous-transaction : une ligne incohérente n’annule que
    -- le règlement de sa mission, jamais l’appel en cours ni les autres missions.
    begin
      select * into m from public.missions x where x.id = mid for update skip locked;
      continue when not found;
      update public.applications x set status = 'expired'
        where x.mission_id = mid and x.status = 'offered' and x.offer_expires_at <= now();
      pay_due := exists (select 1 from public.assignments y
                         where y.mission_id = mid and y.status = 'submitted' and y.auto_validate_at <= now());
      close_due := m.start_at <= now()
                   and (m.status = 'published' or (m.status = 'filled' and m.slots_free > 0));
      if pay_due or close_due then
        -- Ordre des verrous : mission, puis portefeuille de l’annonceur.
        perform 1 from public.wallets w where w.poster_id = m.poster_id for update skip locked;
        continue when not found and exists (select 1 from public.wallets w where w.poster_id = m.poster_id);
      end if;
      if pay_due then
        for aid in
          select y.id from public.assignments y
            where y.mission_id = mid and y.status = 'submitted' and y.auto_validate_at <= now()
            order by y.id
        loop
          perform public.pay_assignment(aid);
        end loop;
      end if;
      if close_due then
        update public.applications x set status = 'rejected'
          where x.mission_id = mid and x.status in ('pending', 'pending_sync');
        update public.applications x set status = 'expired'
          where x.mission_id = mid and x.status = 'offered';
        if not exists (select 1 from public.assignments y where y.mission_id = mid and y.status <> 'cancelled') then
          update public.missions x set status = 'cancelled' where x.id = mid;
          delete from public.blocked_funds b where b.mission_id = mid;
        else
          select b.amount into blocked from public.blocked_funds b where b.mission_id = mid for update;
          freed := least(coalesce(blocked, 0)::bigint, m.slot_amount::bigint * m.slots_free)::integer;
          if freed > 0 and freed = blocked then
            delete from public.blocked_funds b where b.mission_id = mid;
          elsif freed > 0 then
            update public.blocked_funds b set amount = blocked - freed where b.mission_id = mid;
          end if;
          update public.missions x set status = 'filled', slots_free = 0 where x.id = mid;
        end if;
      end if;
    exception when others then
      raise warning 'settle_due: mission % ignorée : %', mid, sqlerrm;
    end;
  end loop;
end $$;

-- ---------------------------------------------------------------------------
-- Explorer : candidatures ouvertes seulement, position de l’appareil facultative.
-- ---------------------------------------------------------------------------
drop function if exists public.list_missions(integer, text, integer, text, boolean, text, text);

create or replace function public.list_missions(km integer default null, cat text default null,
  min integer default null, "when" text default null, multi boolean default null,
  city text default null, q text default null,
  lat double precision default null, lng double precision default null) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  p public.profiles;
  radius integer := coalesce(list_missions.km, 5);
  cats text[] := array_remove(string_to_array(coalesce(list_missions.cat, ''), ','), '');
  period text := coalesce(list_missions."when", 'all');
  needle text := lower(trim(coalesce(list_missions.q, '')));
  today date := public.benin_day(now());
  device boolean := list_missions.lat is not null and list_missions.lng is not null;
  from_lat double precision;
  from_lng double precision;
  items jsonb;
  total integer;
begin
  perform public.settle_due();
  select * into p from public.profiles x where x.id = me;
  -- Position de l’appareil si elle est donnée, sinon celle du profil.
  from_lat := case when device then list_missions.lat else p.lat end;
  from_lng := case when device then list_missions.lng else p.lng end;
  select coalesce(jsonb_agg(public.public_mission_json(m, me) order by m.published_at desc, m.id), '[]'::jsonb),
         count(*)
    into items, total
    from public.missions m
    where m.status = 'published' and m.slots_free > 0 and m.apply_deadline > now() and m.poster_id <> me
      and (case when list_missions.city is not null then m.city = list_missions.city
                else public.distance_km(from_lat, from_lng, m.zone_lat, m.zone_lng) <= radius end)
      and (cardinality(cats) = 0 or m.category = any(cats))
      and (list_missions.min is null or m.slot_amount >= list_missions.min)
      and (period <> 'today' or public.benin_day(m.start_at) - today = 0)
      and (period <> 'week' or public.benin_day(m.start_at) - today <= 6)
      and (list_missions.multi is not true or m.slots_total >= 2)
      and (needle = '' or position(needle in lower(m.title || ' ' || m.description || ' ' ||
        coalesce(case m.category
          when 'event' then 'événement'
          when 'delivery' then 'livraison'
          when 'shopping' then 'courses'
          when 'computer' then 'informatique'
          when 'data_entry' then 'saisie de données'
          when 'cleaning' then 'nettoyage'
          when 'repair' then 'réparation'
          when 'flyers' then 'flyers'
          when 'other' then 'autre'
        end, 'null'))) > 0);
  return jsonb_build_object(
    'items', items,
    'total', total,
    'radiusKm', radius,
    'updatedAt', public.iso(now() - interval '2 minutes'));
end $$;

-- Carte des villes : mêmes missions qu’Explorer (candidatures ouvertes).
create or replace function public.list_cities() returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  p public.profiles;
begin
  perform public.settle_due();
  select * into p from public.profiles where id = me;
  return jsonb_build_object(
    'userLat', p.lat,
    'userLng', p.lng,
    'items', coalesce((
      select jsonb_agg(jsonb_build_object(
          'city', c.city,
          'count', c.n,
          'lat', coalesce(c.lat, p.lat),
          'lng', coalesce(c.lng, p.lng),
          'minPay', c.min_pay,
          'maxPay', c.max_pay) order by c.n desc, c.first_seen)
      from (
        select m.city, count(*)::int as n, min(m.slot_amount) as min_pay, max(m.slot_amount) as max_pay,
               min(m.published_at) as first_seen, ctr.lat, ctr.lng
        from public.missions m
        left join public.cities ctr on ctr.name = m.city
        where m.status = 'published' and m.slots_free > 0 and m.apply_deadline > now() and m.poster_id <> me
        group by m.city, ctr.lat, ctr.lng) c), '[]'::jsonb));
end $$;

-- ---------------------------------------------------------------------------
-- Candidature : close à la date limite.
-- ---------------------------------------------------------------------------
create or replace function public.apply_to_mission(mission_id text, message text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  m public.missions;
  kyc text;
  body text := trim(coalesce(apply_to_mission.message, ''));
  a public.applications;
  known boolean;
begin
  select * into m from public.missions where id = apply_to_mission.mission_id for update;
  known := found;  -- PERFORM ci-dessous remet FOUND à vrai.
  perform public.settle_due();
  if known then
    -- Relue après le règlement (qui a pu clore le recrutement).
    select * into m from public.missions where id = apply_to_mission.mission_id;
  end if;
  if not known or m.status <> 'published' then
    perform public.err('404', 'Cette mission n’est plus disponible.');
  end if;
  if m.poster_id = me then
    perform public.err('422', 'Vous ne pouvez pas postuler à votre propre mission.');
  end if;
  if m.apply_deadline <= now() then
    perform public.err('409', 'Les candidatures sont closes pour cette mission.');
  end if;
  select kyc_status into kyc from public.profiles where id = me;
  if kyc is null or kyc not in ('pending', 'verified') then
    perform public.err('422', 'Envoyez votre pièce d’identité avant de postuler.');
  end if;
  if m.slots_free <= 0 then
    perform public.err('409', 'Cette mission est complète.');
  end if;
  if exists (select 1 from public.applications x
             where x.mission_id = m.id and x.worker_id = me and x.status <> 'withdrawn') then
    perform public.err('409', 'Vous avez déjà postulé à cette mission.');
  end if;
  if char_length(body) > 300 then
    perform public.err('422', 'Votre message dépasse 300 caractères.');
  end if;
  -- Une seule ligne par (mission, exécutant) : une candidature retirée est rouverte.
  insert into public.applications as x (mission_id, worker_id, status, message, created_at)
    values (m.id, me, 'pending', body, now())
    on conflict on constraint applications_mission_id_worker_id_key do update
      set status = 'pending', message = excluded.message, created_at = excluded.created_at,
          offer_expires_at = null, assignment_id = null
      where x.status = 'withdrawn'
    returning * into a;
  return public.application_json(a);
end $$;

-- ---------------------------------------------------------------------------
-- Offre et confirmation : refusées une fois la mission commencée.
-- ---------------------------------------------------------------------------
create or replace function public.offer_application(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  m public.missions := public.own_mission(public.poster_application_mission(offer_application.id));
  a public.applications;
  taken integer;
begin
  if m.start_at <= now() then
    perform public.err('409', 'La mission a déjà commencé.');
  end if;
  perform public.settle_due();
  select * into a from public.applications x where x.id = offer_application.id for update;
  if a.status not in ('pending', 'pending_sync') then
    perform public.err('409', 'Cette candidature n’est plus en attente.');
  end if;
  -- Offres en cours + affectations actives ≤ places.
  select (select count(*) from public.applications x where x.mission_id = m.id and x.status = 'offered')
       + (select count(*) from public.assignments y where y.mission_id = m.id and y.status <> 'cancelled')
    into taken;
  if taken >= m.slots_total then
    perform public.err('409', 'Plus de place libre sur cette mission.');
  end if;
  update public.applications x set status = 'offered', offer_expires_at = now() + interval '12 hours'
    where x.id = a.id returning * into a;
  return public.candidate_json(a);
end $$;

create or replace function public.confirm_offer(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  a public.applications;
  m public.missions;
  new_id text;
begin
  -- Ordre des verrous : mission, puis candidature (revérifiée après verrou).
  select * into m from public.missions
    where missions.id = public.my_application_mission(confirm_offer.id) for update;
  if m.start_at <= now() then
    perform public.err('409', 'La mission a déjà commencé.');
  end if;
  perform public.settle_due();
  a := public.my_application(confirm_offer.id);
  -- Une offre échue n’est plus disponible, même avant le passage du règlement.
  if a.status <> 'offered' or (a.offer_expires_at is not null and a.offer_expires_at <= now()) then
    perform public.err('409', 'Cette offre n’est plus disponible.');
  end if;
  insert into public.assignments (mission_id, application_id, worker_id, status, pay_amount, payout_operator)
    values (m.id, a.id, a.worker_id, 'confirmed', m.slot_amount, 'MTN MoMo')
    returning assignments.id into new_id;
  update public.applications x set status = 'confirmed', assignment_id = new_id
    where x.id = a.id returning * into a;
  update public.missions set slots_free = greatest(slots_free - 1, 0)
    where missions.id = m.id returning * into m;
  -- Mission complète : les autres candidatures en attente sont closes.
  if m.slots_free <= 0 then
    update public.applications x set status = 'rejected'
      where x.mission_id = m.id and x.status in ('pending', 'pending_sync');
  end if;
  return public.application_json(a);
end $$;

-- ---------------------------------------------------------------------------
-- Pièce d’identité : recto et verso d’abord, puis le selfie.
-- ---------------------------------------------------------------------------
create or replace function public.submit_kyc(document_type text, country_code text,
  front_path text, back_path text, selfie_path text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  folder text := public.uid()::text || '/';
  submitted timestamptz;
begin
  if document_type is null or document_type not in ('id_card', 'passport') then
    perform public.err('422', 'Type de pièce inconnu.');
  end if;
  if trim(coalesce(country_code, '')) = '' then
    perform public.err('422', 'Indiquez le pays de la pièce.');
  end if;
  -- Recto toujours, verso sauf passeport, puis le selfie. Les photos doivent être
  -- dans le dossier de l’utilisateur (bucket kyc).
  if coalesce(front_path, '') = ''
     or (document_type <> 'passport' and coalesce(back_path, '') = '')
     or not starts_with(front_path, folder)
     or (coalesce(back_path, '') <> '' and not starts_with(back_path, folder)) then
    perform public.err('422', 'Photographiez le recto et le verso.');
  end if;
  if coalesce(selfie_path, '') = '' or not starts_with(selfie_path, folder) then
    perform public.err('422', 'Prenez un selfie pour vérifier votre identité.');
  end if;
  insert into public.kyc_submissions (user_id, doc_type, country_code, paths)
    values (me, document_type, trim(country_code), jsonb_build_object(
      'front', front_path, 'back', nullif(back_path, ''), 'selfie', selfie_path))
    returning submitted_at into submitted;
  update public.profiles set kyc_status = 'pending' where id = me;
  return jsonb_build_object('status', 'pending', 'submittedAt', public.iso(submitted));
end $$;

-- ---------------------------------------------------------------------------
-- Droits : la nouvelle signature de list_missions (les autres sont conservés).
-- ---------------------------------------------------------------------------
revoke all on function public.list_missions(integer, text, integer, text, boolean, text, text,
  double precision, double precision) from public, anon;
grant execute on function public.list_missions(integer, text, integer, text, boolean, text, text,
  double precision, double precision) to authenticated;
