-- Côté annonceur : publication, Mes missions, candidats, validation, contestation,
-- annulation et portefeuille ; versements et échéances (settle_due, planifiée par
-- pg_cron). Les règles, les messages et le JSON reprennent ceux du faux serveur
-- (poster_handlers.dart, settlement.dart).
--
-- Règlement : comme le faux serveur règle les échéances avant chaque requête, chaque
-- RPC (annonceur et exécutant) appelle public.settle_due() avant de lire ou d’écrire.
--
-- Ordre des verrous (complète la règle de 000004) :
--   mission, puis portefeuille de l’annonceur, puis règlement, puis candidature, puis
--   affectation, puis montant bloqué (blocked_funds).
-- - settle_due() n’attend jamais : il prend les missions et les portefeuilles avec
--   « skip locked » (ce qui est occupé est réglé au passage suivant). Il ne peut donc
--   pas fermer un cycle d’attente.
-- - Une RPC verrouille d’abord sa mission (et, si elle touche à l’argent, le
--   portefeuille de l’annonceur), puis appelle settle_due(). Après le règlement, elle
--   n’attend plus que des lignes protégées par sa mission.
-- - Candidatures, affectations et montants bloqués d’une mission ne sont verrouillés
--   que par qui détient déjà la mission.
-- - publish_mission verrouille le portefeuille sans mission : la mission est créée
--   ensuite, aucune autre transaction ne peut l’attendre.

-- Un seul versement par affectation.
create unique index if not exists payouts_one_per_assignment
  on public.payouts (assignment_id) where assignment_id is not null;
-- Recherche des échéances.
create index if not exists applications_offer_due
  on public.applications (offer_expires_at) where status = 'offered';
create index if not exists assignments_auto_validate_due
  on public.assignments (auto_validate_at) where status = 'submitted';

-- ---------------------------------------------------------------------------
-- Aides internes (aucun droit d’exécution pour les clients).
-- ---------------------------------------------------------------------------

-- « 5 000 FCFA » : espace fine insécable entre milliers, insécable avant la devise
-- (formatFcfa côté client).
create or replace function public.format_fcfa(n bigint) returns text
language sql immutable as $$
  select case when n < 0 then '-' else '' end
    || regexp_replace(abs(n)::text, '(\d)(?=(\d{3})+$)', '\1' || U&'\202F', 'g')
    || U&'\00A0' || 'FCFA'
$$;

-- Lecture typée d’une valeur JSON du corps de requête (null si absente ou d’un autre type).
create or replace function public.jtext(j jsonb) returns text
language sql immutable as $$
  select case when jsonb_typeof(j) = 'string' then j #>> '{}' end
$$;

-- Nombre JSON tronqué en entier (num.toInt()), borné aux entiers 32 bits.
create or replace function public.jint(j jsonb) returns integer
language sql immutable as $$
  select case when jsonb_typeof(j) = 'number'
    then least(greatest(trunc((j #>> '{}')::numeric), -2147483648), 2147483647)::integer end
$$;

create or replace function public.jfloat(j jsonb) returns double precision
language sql immutable as $$
  select case when jsonb_typeof(j) = 'number' then (j #>> '{}')::double precision end
$$;

-- Valeur JSON, null SQL si absente ou JSON null (l’opérateur ?? côté Dart).
create or replace function public.jvalue(j jsonb) returns jsonb
language sql immutable as $$
  select nullif(j, 'null'::jsonb)
$$;

-- Date ISO 8601 (DateTime.tryParse) ; null si illisible. Les mots-clés de Postgres
-- (now, infinity…) sont refusés.
create or replace function public.parse_instant(t text) returns timestamptz
language plpgsql stable as $$
begin
  if t is null or t !~ '^\d{4}-\d{2}-\d{2}' then
    return null;
  end if;
  return t::timestamptz;
exception when others then
  return null;
end $$;

-- Montant brut versé pour une place : le taux pour flat/daily, taux × durée pour
-- hourly (slotAmountFor). Bloqué à la publication × places.
create or replace function public.slot_amount_for(pay_unit text, pay_amount integer, duration_min integer)
returns bigint
language sql immutable as $$
  select case when pay_unit = 'hourly'
    then round(pay_amount::numeric * duration_min / 60)::bigint else pay_amount::bigint end
$$;

-- Mission vue par son annonceur (posterMissionJson).
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
      when s.confirmed > 0 and s.paid = s.confirmed and m.slots_free <= 0 then 'completed'
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

-- Missions réalisées par catégorie : celles du profil, plus une par affectation payée
-- de l’exécutant (catégorie de la mission), ajoutées à la suite.
create or replace function public.done_missions(worker uuid, profile jsonb) returns jsonb
language sql stable as $$
  select coalesce(jsonb_agg(jsonb_build_object('category', c.category, 'count', c.n)
           order by c.pos, c.first_paid, c.category), '[]'::jsonb)
  from (
    select u.category, sum(u.n)::int as n, min(u.pos) as pos, min(u.first_paid) as first_paid
    from (
      select public.jtext(d->'category') as category, coalesce(public.jint(d->'count'), 0) as n,
             e.ord as pos, null::timestamptz as first_paid
      from jsonb_array_elements(case when jsonb_typeof(profile->'doneMissions') = 'array'
                                     then profile->'doneMissions' else '[]'::jsonb end)
           with ordinality as e(d, ord)
      union all
      select m.category, count(*)::int, null, min(p.validated_at)
      from public.assignments a
      join public.missions m on m.id = a.mission_id
      left join public.payouts p on p.id = a.payout_id
      where a.worker_id = worker and a.status = 'paid'
      group by m.category) u
    where u.category is not null
    group by u.category) c
$$;

-- Candidat vu par l’annonceur (candidateJson) : profil, statut et présence. Un compte
-- sans profil d’exécutant a des valeurs par défaut. L’affectation affichée est celle
-- de la candidature (assignment_id) : une candidature rouverte après désistement n’en
-- a plus.
create or replace function public.candidate_json(app public.applications) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'id', app.id,
    'workerId', app.worker_id,
    'name', trim(p.first_name || ' ' || p.last_name),
    'city', coalesce(p.city, ''),
    'memberSince', coalesce(public.jvalue(w.wp->'memberSince'), to_jsonb(public.iso(p.created_at))),
    'pitch', coalesce(public.jvalue(w.wp->'pitch'), to_jsonb(app.message), '""'::jsonb),
    'skills', coalesce(public.jvalue(w.wp->'skills'), '[]'::jsonb),
    'verified', coalesce(public.jvalue(w.wp->'verified'), 'false'::jsonb),
    'isExpert', coalesce(r.rating >= 4.8 and r.missions_count >= 20, false),
    'rating', r.rating,
    'reviewsCount', coalesce(public.jvalue(w.wp->'reviewsCount'), '0'::jsonb),
    'missionsCount', r.missions_count,
    'doneMissions', public.done_missions(app.worker_id, w.wp),
    'review', public.jvalue(w.wp->'lastReview'),
    'reliability', public.jvalue(w.wp->'reliability'),
    'absences', coalesce(public.jvalue(w.wp->'absences'), '0'::jsonb),
    'status', case app.status
      when 'pending' then 'pending'
      when 'pending_sync' then 'pending'
      when 'offered' then 'retained'
      when 'confirmed' then 'confirmed'
      else 'refused' end,
    'attendance', case a.status
      when 'in_progress' then 'arrived'
      when 'submitted' then 'finished'
      when 'paid' then 'validated'
      when 'contested' then 'contested'
      else 'notArrived' end,
    'assignmentId', a.id,
    'arrivedAt', public.iso(a.check_in_at),
    'finishedAt', public.iso(a.check_out_at),
    'autoPayAt', public.iso(a.auto_validate_at),
    'distanceMeters', a.check_in_distance_m,
    'proofPhotos', coalesce(jsonb_array_length(a.photos), 0),
    'completionNote', a.note,
    'offerExpiresAt', public.iso(app.offer_expires_at))
  from public.profiles p
  cross join lateral (select coalesce(p.worker_profile, '{}'::jsonb) as wp) w
  cross join lateral (select public.jfloat(w.wp->'rating') as rating,
                             coalesce(public.jint(w.wp->'missionsCount'), 0) as missions_count) r
  left join public.assignments a on a.id = app.assignment_id and a.application_id = app.id
  where p.id = app.worker_id
$$;

-- Portefeuille de l’annonceur (getWallet).
create or replace function public.wallet_json(poster uuid) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'balance', s.balance,
    'available', s.balance - s.blocked,
    'blocked', coalesce((
      select jsonb_agg(jsonb_build_object(
          'missionId', b.mission_id,
          'title', coalesce(m.title, ''),
          'amount', b.amount) order by m.published_at, b.mission_id)
      from public.blocked_funds b left join public.missions m on m.id = b.mission_id
      where b.poster_id = poster and b.amount > 0), '[]'::jsonb),
    'payouts', coalesce((
      select jsonb_agg(jsonb_build_object(
          'id', p.id,
          'missionTitle', p.mission_title,
          'workerName', coalesce(w.first_name || ' ' || w.last_name, ''),
          'amount', p.amount,
          'paidAt', public.iso(p.validated_at)) order by p.validated_at desc, p.id desc)
      from public.payouts p left join public.profiles w on w.id = p.worker_id
      where p.poster_id = poster), '[]'::jsonb))
  from (select
      coalesce((select x.balance from public.wallets x where x.poster_id = poster), 0) as balance,
      coalesce((select sum(b.amount) from public.blocked_funds b where b.poster_id = poster), 0)::int as blocked) s
$$;

-- Mission de l’appelant, verrouillée ; 404 sinon.
create or replace function public.own_mission(id text) returns public.missions
language plpgsql set search_path = public as $$
declare m public.missions;
begin
  select * into m from public.missions x
    where x.id = own_mission.id and x.poster_id = public.uid() for update;
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return m;
end $$;

-- Mission d’une candidature à une mission de l’appelant, lue sans verrou ; 404 sinon.
create or replace function public.poster_application_mission(id text) returns text
language plpgsql stable set search_path = public as $$
declare mid text;
begin
  select x.mission_id into mid from public.applications x
    join public.missions m on m.id = x.mission_id
    where x.id = poster_application_mission.id and m.poster_id = public.uid();
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return mid;
end $$;

-- Mission d’une affectation sur une mission de l’appelant, lue sans verrou ; 404 sinon.
create or replace function public.poster_assignment_mission(id text) returns text
language plpgsql stable set search_path = public as $$
declare mid text;
begin
  select x.mission_id into mid from public.assignments x
    join public.missions m on m.id = x.mission_id
    where x.id = poster_assignment_mission.id and m.poster_id = public.uid();
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return mid;
end $$;

-- ---------------------------------------------------------------------------
-- Versements et échéances
-- ---------------------------------------------------------------------------

-- Verse le montant de l’affectation (payAssignment) : débite le solde de l’annonceur,
-- réduit d’autant son montant bloqué (ligne supprimée à zéro), crée le reçu de
-- l’exécutant. Sans effet si déjà payée.
create or replace function public.pay_assignment(a_id text) returns void
language plpgsql security definer set search_path = public as $$
declare
  mid text;
  m public.missions;
  a public.assignments;
  blocked integer;
  remaining integer;
  seq bigint;
  pid text;
  acct jsonb;
  has_wallet boolean;
begin
  select x.mission_id into mid from public.assignments x where x.id = a_id;
  if not found then
    raise exception 'Affectation inconnue : %', a_id;
  end if;
  -- Ordre des verrous (celui de l’en-tête) : mission, portefeuille de l’annonceur,
  -- affectation, montant bloqué. Les appelants (validate_assignment, settle_due)
  -- détiennent déjà la mission et le portefeuille : ces deux verrous sont repris sans
  -- attente ; l’affectation et le montant bloqué ne sont verrouillés que par qui
  -- détient la mission.
  select * into m from public.missions x where x.id = mid for update;
  perform 1 from public.wallets w where w.poster_id = m.poster_id for update;
  has_wallet := found;
  select * into a from public.assignments x where x.id = a_id for update;
  if a.status = 'paid' then
    return;
  end if;
  if has_wallet then
    -- Le solde ne peut pas devenir négatif (contrainte balance >= 0).
    update public.wallets w set balance = w.balance - a.pay_amount where w.poster_id = m.poster_id;
    select b.amount into blocked from public.blocked_funds b where b.mission_id = m.id for update;
    remaining := coalesce(blocked, 0) - a.pay_amount;
    if remaining < 0 then
      raise exception 'Montant bloqué insuffisant pour % : % à verser.', m.id, a.pay_amount;
    end if;
    if remaining = 0 then
      delete from public.blocked_funds b where b.mission_id = m.id;
    else
      update public.blocked_funds b set amount = remaining where b.mission_id = m.id;
    end if;
  end if;
  seq := nextval('public.payout_seq');
  pid := 'po' || seq;
  select p.payout_account into acct from public.profiles p where p.id = a.worker_id;
  insert into public.payouts (id, worker_id, poster_id, assignment_id, amount, gross_amount, mission_title,
      poster_name, validated_at, commission_label, account_label, reference, status)
    values (pid, a.worker_id, m.poster_id, a.id, a.pay_amount, a.pay_amount, m.title,
      coalesce(public.poster_public(m.poster_id)->>'displayName', ''), now(), 'Aucune (démo)',
      coalesce(acct->>'operator', '') || ' · •• ' || regexp_replace(coalesce(acct->>'maskedNumber', ''), '^.* ', ''),
      'MO-' || to_char(now() at time zone 'UTC', 'YYYY') || '-' || lpad(seq::text, greatest(6, length(seq::text)), '0'),
      'paid');
  update public.assignments x set status = 'paid', payout_id = pid where x.id = a.id;
end $$;

-- Échéances (settle) : offres échues → expired ; affectations soumises dont
-- l’échéance est passée → versées. Idempotente. N’attend jamais : une mission ou un
-- portefeuille verrouillé par une autre transaction est réglé au passage suivant.
-- Une mission dont le règlement échoue est ignorée (avertissement) ; la validation
-- directe (validate_assignment) lève, elle, l’erreur.
create or replace function public.settle_due() returns void
language plpgsql security definer set search_path = public as $$
declare
  mid text;
  poster uuid;
  aid text;
begin
  for mid in
    select x.mission_id from public.applications x
      where x.status = 'offered' and x.offer_expires_at <= now()
    union
    select y.mission_id from public.assignments y
      where y.status = 'submitted' and y.auto_validate_at <= now()
    order by 1
  loop
    -- Chaque mission dans sa sous-transaction : une ligne incohérente n’annule que
    -- le règlement de sa mission, jamais l’appel en cours ni les autres missions.
    begin
      select m.poster_id into poster from public.missions m where m.id = mid for update skip locked;
      continue when not found;
      update public.applications x set status = 'expired'
        where x.mission_id = mid and x.status = 'offered' and x.offer_expires_at <= now();
      if exists (select 1 from public.assignments y
                 where y.mission_id = mid and y.status = 'submitted' and y.auto_validate_at <= now()) then
        perform 1 from public.wallets w where w.poster_id = poster for update skip locked;
        continue when not found and exists (select 1 from public.wallets w where w.poster_id = poster);
        for aid in
          select y.id from public.assignments y
            where y.mission_id = mid and y.status = 'submitted' and y.auto_validate_at <= now()
            order by y.id
        loop
          perform public.pay_assignment(aid);
        end loop;
      end if;
    exception when others then
      raise warning 'settle_due: mission % ignorée : %', mid, sqlerrm;
    end;
  end loop;
end $$;

-- ---------------------------------------------------------------------------
-- RPC annonceur
-- ---------------------------------------------------------------------------

create or replace function public.publish_mission(body jsonb) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  b jsonb := case when jsonb_typeof(publish_mission.body) = 'object' then publish_mission.body else '{}'::jsonb end;
  v_title text := trim(coalesce(public.jtext(b->'title'), ''));
  v_slots integer := coalesce(public.jint(b->'slots'), 0);
  v_pay integer := coalesce(public.jint(b->'payAmount'), 0);
  v_start timestamptz := public.parse_instant(public.jtext(b->'startAt'));
  v_duration integer := coalesce(public.jint(b->'durationMin'), 0);
  v_unit text := coalesce(public.jtext(b->'payUnit'), 'flat');
  v_deadline timestamptz := public.parse_instant(public.jtext(b->'applyDeadline'));
  v_city text := coalesce(public.jtext(b->'city'), '');
  v_description text := coalesce(public.jtext(b->'description'), '');
  v_lat double precision := public.jfloat(b->'lat');
  v_lng double precision := public.jfloat(b->'lng');
  slot bigint;
  total bigint;
  available bigint;
  m public.missions;
begin
  -- Portefeuille d’abord (la mission n’existe pas encore), puis le règlement.
  perform 1 from public.wallets w where w.poster_id = me for update;
  perform public.settle_due();
  if not exists (select 1 from public.profiles p where p.id = me and p.poster_profile is not null) then
    perform public.err('403', 'Passez en mode annonceur pour publier.');
  end if;
  if v_title = '' then
    perform public.err('422', 'Indiquez un titre.');
  end if;
  if v_slots < 1 or v_slots > 50 then
    perform public.err('422', 'Le nombre de places va de 1 à 50.');
  end if;
  if v_pay <= 0 then
    perform public.err('422', 'Indiquez la rémunération.');
  end if;
  if v_start is null or v_start <= now() then
    perform public.err('422', 'La date de début doit être à venir.');
  end if;
  if v_unit = 'hourly' and v_duration <= 0 then
    perform public.err('422', 'Indiquez la durée.');
  end if;
  if v_unit not in ('flat', 'hourly', 'daily') then
    perform public.err('422', 'Indiquez la rémunération.');
  end if;
  slot := public.slot_amount_for(v_unit, v_pay, v_duration);
  total := slot * v_slots;
  available := coalesce((select w.balance from public.wallets w where w.poster_id = me), 0)
             - coalesce((select sum(x.amount) from public.blocked_funds x where x.poster_id = me), 0);
  if total > available then
    perform public.err('422', 'Solde insuffisant pour bloquer ' || public.format_fcfa(total) || '.');
  end if;
  if v_lat is null or v_lng is null then
    perform public.err('422', 'Indiquez le lieu de la mission.');
  end if;
  if v_deadline is not null and (v_deadline <= now() or v_deadline >= v_start) then
    perform public.err('422', 'La date limite de candidature doit être avant le début et dans le futur.');
  end if;
  insert into public.missions (poster_id, title, category, description, city, zone_lat, zone_lng, start_at,
      duration_min, pay_amount, pay_unit, slot_amount, slots_total, slots_free, apply_deadline, published_at,
      status, public_questions_count)
    values (me, v_title, coalesce(public.jtext(b->'category'), 'other'), v_description, v_city,
      round(v_lat::numeric, 2)::double precision, round(v_lng::numeric, 2)::double precision, v_start,
      v_duration, v_pay, v_unit, slot::integer, v_slots, v_slots, coalesce(v_deadline, v_start),
      clock_timestamp(), 'published', 0)
    returning * into m;
  insert into public.mission_locations (mission_id, district, address, landmark, lat, lng, briefing)
    values (m.id, v_city, coalesce(public.jtext(b->'address'), ''), coalesce(public.jtext(b->'landmark'), ''),
      v_lat, v_lng, v_description);
  if total > 0 then
    insert into public.blocked_funds (mission_id, poster_id, amount) values (m.id, me, total::integer);
  end if;
  return public.poster_mission_json(m);
end $$;

create or replace function public.list_my_missions() returns jsonb
language plpgsql security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  perform public.settle_due();
  return coalesce((select jsonb_agg(public.poster_mission_json(m) order by m.published_at desc, m.id)
    from public.missions m where m.poster_id = me), '[]'::jsonb);
end $$;

create or replace function public.get_my_mission(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  m public.missions;
begin
  perform public.settle_due();
  select * into m from public.missions x where x.id = get_my_mission.id and x.poster_id = me;
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return public.poster_mission_json(m);
end $$;

create or replace function public.list_candidates(mission_id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  perform public.settle_due();
  if not exists (select 1 from public.missions m where m.id = list_candidates.mission_id and m.poster_id = me) then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return coalesce((select jsonb_agg(public.candidate_json(x) order by x.created_at, x.id)
    from public.applications x
    where x.mission_id = list_candidates.mission_id and x.status <> 'withdrawn'), '[]'::jsonb);
end $$;

create or replace function public.offer_application(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  m public.missions := public.own_mission(public.poster_application_mission(offer_application.id));
  a public.applications;
  taken integer;
begin
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

create or replace function public.reject_application(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  m public.missions := public.own_mission(public.poster_application_mission(reject_application.id));
  a public.applications;
begin
  perform public.settle_due();
  select * into a from public.applications x where x.id = reject_application.id for update;
  if a.status not in ('pending', 'pending_sync', 'offered') then
    perform public.err('409', 'Cette candidature n’est plus en attente.');
  end if;
  update public.applications x set status = 'rejected' where x.id = a.id returning * into a;
  return public.candidate_json(a);
end $$;

create or replace function public.validate_assignment(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  m public.missions := public.own_mission(public.poster_assignment_mission(validate_assignment.id));
  a public.assignments;
  app public.applications;
begin
  perform 1 from public.wallets w where w.poster_id = m.poster_id for update;
  perform public.settle_due();
  select * into a from public.assignments x where x.id = validate_assignment.id for update;
  if a.status <> 'submitted' then
    perform public.err('409', 'Rien à valider.');
  end if;
  perform public.pay_assignment(a.id);
  select * into app from public.applications x where x.id = a.application_id;
  return public.candidate_json(app);
end $$;

create or replace function public.contest_assignment(id text, reason text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  m public.missions := public.own_mission(public.poster_assignment_mission(contest_assignment.id));
  a public.assignments;
  app public.applications;
  motive text := trim(coalesce(contest_assignment.reason, ''));
begin
  perform public.settle_due();
  select * into a from public.assignments x where x.id = contest_assignment.id for update;
  if a.status <> 'submitted' then
    perform public.err('409', 'Rien à valider.');
  end if;
  if motive = '' then
    perform public.err('422', 'Indiquez le motif.');
  end if;
  update public.assignments x set status = 'contested', contest_reason = motive where x.id = a.id;
  select * into app from public.applications x where x.id = a.application_id;
  return public.candidate_json(app);
end $$;

create or replace function public.cancel_mission(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare m public.missions := public.own_mission(cancel_mission.id);
begin
  perform 1 from public.wallets w where w.poster_id = m.poster_id for update;
  perform public.settle_due();
  if m.status = 'cancelled' then
    perform public.err('409', 'Cette mission est déjà annulée.');
  end if;
  if exists (select 1 from public.assignments y
             where y.mission_id = m.id and y.status in ('in_progress', 'submitted', 'contested', 'paid')) then
    perform public.err('409', 'Impossible d’annuler : la mission a commencé.');
  end if;
  update public.missions x set status = 'cancelled' where x.id = m.id returning * into m;
  -- Ordre : candidatures, puis affectations (toutes protégées par la mission).
  update public.applications x set status = 'cancelled'
    from public.assignments y
    where y.mission_id = m.id and y.status = 'confirmed' and x.id = y.application_id;
  update public.applications x set status = 'rejected'
    where x.mission_id = m.id and x.status in ('pending', 'pending_sync', 'offered');
  update public.assignments y set status = 'cancelled', cancelled_by = 'poster'
    where y.mission_id = m.id and y.status = 'confirmed';
  delete from public.blocked_funds b where b.mission_id = m.id;
  return public.poster_mission_json(m);
end $$;

create or replace function public.get_wallet() returns jsonb
language plpgsql security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  perform public.settle_due();
  return public.wallet_json(me);
end $$;

-- ---------------------------------------------------------------------------
-- RPC exécutant (000004) : même corps, précédé du règlement. Les RPC d’écriture
-- verrouillent d’abord leur mission, puis règlent ; les lectures règlent seulement.
-- Les fonctions deviennent volatiles (elles écrivent via settle_due).
-- ---------------------------------------------------------------------------

create or replace function public.list_missions(km integer default null, cat text default null,
  min integer default null, "when" text default null, multi boolean default null,
  city text default null, q text default null) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  p public.profiles;
  radius integer := coalesce(list_missions.km, 5);
  cats text[] := array_remove(string_to_array(coalesce(list_missions.cat, ''), ','), '');
  period text := coalesce(list_missions."when", 'all');
  needle text := lower(trim(coalesce(list_missions.q, '')));
  today date := public.benin_day(now());
  items jsonb;
  total integer;
begin
  perform public.settle_due();
  select * into p from public.profiles where id = me;
  select coalesce(jsonb_agg(public.public_mission_json(m, me) order by m.published_at desc, m.id), '[]'::jsonb),
         count(*)
    into items, total
    from public.missions m
    where m.status = 'published' and m.slots_free > 0 and m.poster_id <> me
      and (case when list_missions.city is not null then m.city = list_missions.city
                else public.distance_km(p.lat, p.lng, m.zone_lat, m.zone_lng) <= radius end)
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
        where m.status = 'published' and m.slots_free > 0 and m.poster_id <> me
        group by m.city, ctr.lat, ctr.lng) c), '[]'::jsonb));
end $$;

create or replace function public.get_mission(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  m public.missions;
begin
  perform public.settle_due();
  select * into m from public.missions where missions.id = get_mission.id;
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return public.public_mission_json(m, me);
end $$;

create or replace function public.get_poster(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  pid uuid;
  pp jsonb;
begin
  perform public.settle_due();
  perform public.uid();
  begin
    pid := get_poster.id::uuid;
  exception when invalid_text_representation then
    pid := null;
  end;
  select p.poster_profile into pp from public.profiles p where p.id = pid;
  if pp is null then
    perform public.err('404', 'Annonceur introuvable.');
  end if;
  return pp || jsonb_build_object('reviews', coalesce((
    select jsonb_agg(jsonb_build_object(
        'authorName', r.author_name,
        'stars', r.stars,
        'comment', r.comment,
        'context', r.context,
        'date', public.iso(r.date),
        'reply', r.reply) order by r.date desc, r.id)
    from public.poster_reviews r where r.poster_id = pid), '[]'::jsonb));
end $$;

create or replace function public.list_my_applications() returns jsonb
language plpgsql security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  perform public.settle_due();
  return coalesce((select jsonb_agg(public.application_json(a) order by a.created_at desc, a.id)
    from public.applications a where a.worker_id = me), '[]'::jsonb);
end $$;

create or replace function public.get_assignment(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare a public.assignments;
begin
  perform public.settle_due();
  select * into a from public.assignments x
    where x.id = get_assignment.id and x.worker_id = public.uid();
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return public.assignment_json(a, a.worker_id);
end $$;

create or replace function public.get_earnings() returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  upcoming_amount integer;
  upcoming_count integer;
  paid_amount integer;
  paid_count integer;
  lines jsonb;
begin
  perform public.settle_due();
  select coalesce(sum(a.pay_amount), 0)::int, count(*)::int into upcoming_amount, upcoming_count
    from public.assignments a
    where a.worker_id = me and a.status in ('confirmed', 'in_progress', 'submitted', 'contested');
  select coalesce(sum(p.amount), 0)::int, count(*)::int into paid_amount, paid_count
    from public.payouts p
    where p.worker_id = me and p.validated_at > now() - interval '30 days';
  select coalesce(jsonb_agg(l.line order by l.date desc), '[]'::jsonb) into lines
  from (
    select jsonb_build_object(
        'id', 'l-' || a.id,
        'title', m.title,
        'status', s.status,
        'date', public.iso(s.date),
        'amount', a.pay_amount,
        'payoutId', null) as line,
      s.date
    from public.assignments a
    join public.missions m on m.id = a.mission_id
    cross join lateral (
      select case when a.status in ('confirmed', 'in_progress') then 'reserved' else 'awaiting_validation' end as status,
             case when a.status in ('confirmed', 'in_progress') then m.start_at else a.check_out_at end as date) s
    where a.worker_id = me and a.status in ('confirmed', 'in_progress', 'submitted', 'contested')
    union all
    select jsonb_build_object(
        'id', 'l-' || p.id,
        'title', p.mission_title,
        'status', 'paid',
        'date', public.iso(p.validated_at),
        'amount', p.amount,
        'payoutId', p.id),
      p.validated_at
    from public.payouts p
    where p.worker_id = me) l;
  return jsonb_build_object(
    'upcoming', jsonb_build_object('amount', upcoming_amount, 'count', upcoming_count),
    'paid', jsonb_build_object('amount', paid_amount, 'count', paid_count, 'periodLabel', '30 derniers jours'),
    'payoutAccount', (select payout_account from public.profiles where id = me),
    'lines', lines);
end $$;

create or replace function public.get_payout(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare p public.payouts;
begin
  perform public.settle_due();
  select * into p from public.payouts x where x.id = get_payout.id and x.worker_id = public.uid();
  if not found then
    perform public.err('404', 'Reçu introuvable.');
  end if;
  return public.payout_json(p);
end $$;

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
  if not known or m.status <> 'published' then
    perform public.err('404', 'Cette mission n’est plus disponible.');
  end if;
  if m.poster_id = me then
    perform public.err('422', 'Vous ne pouvez pas postuler à votre propre mission.');
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

create or replace function public.withdraw_application(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare a public.applications;
begin
  -- Ordre des verrous : mission, règlement, puis candidature.
  perform 1 from public.missions m
    where m.id = public.my_application_mission(withdraw_application.id) for update;
  perform public.settle_due();
  a := public.my_application(withdraw_application.id);
  if a.status not in ('pending', 'pending_sync') then
    perform public.err('409', 'Cette candidature ne peut plus être retirée.');
  end if;
  update public.applications x set status = 'withdrawn' where x.id = a.id returning * into a;
  return public.application_json(a);
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

create or replace function public.decline_offer(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare a public.applications;
begin
  -- Ordre des verrous : mission, puis candidature (revérifiée après verrou).
  perform 1 from public.missions
    where missions.id = public.my_application_mission(decline_offer.id) for update;
  perform public.settle_due();
  a := public.my_application(decline_offer.id);
  if a.status <> 'offered' or (a.offer_expires_at is not null and a.offer_expires_at <= now()) then
    perform public.err('409', 'Cette offre n’est plus disponible.');
  end if;
  update public.applications x set status = 'declined' where x.id = a.id returning * into a;
  return public.application_json(a);
end $$;

create or replace function public.check_in(id text, lat double precision, lng double precision) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  a public.assignments;
  l public.mission_locations;
  meters integer;
begin
  -- Ordre des verrous : mission, règlement, puis affectation.
  perform 1 from public.missions m
    where m.id = (select r.mission_id from public.my_assignment_refs(check_in.id) r) for update;
  perform public.settle_due();
  a := public.my_assignment(check_in.id);
  if a.status <> 'confirmed' then
    perform public.err('409', 'Le check-in a déjà été fait.');
  end if;
  select * into l from public.mission_locations where mission_id = a.mission_id;
  meters := round((public.distance_km(check_in.lat, check_in.lng, l.lat, l.lng) * 1000)::numeric);
  if meters is null or meters > 200 then
    perform public.err('422', format('Vous êtes à %s m du lieu : rapprochez-vous à moins de 200 m.', meters));
  end if;
  update public.assignments x set status = 'in_progress', check_in_at = now(), check_in_distance_m = meters
    where x.id = a.id returning * into a;
  return public.assignment_json(a, a.worker_id);
end $$;

create or replace function public.check_out(id text, note text, photos jsonb) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  a public.assignments;
  paths jsonb;
begin
  -- Ordre des verrous : mission, règlement, puis affectation.
  perform 1 from public.missions m
    where m.id = (select r.mission_id from public.my_assignment_refs(check_out.id) r) for update;
  perform public.settle_due();
  a := public.my_assignment(check_out.id);
  if a.status <> 'in_progress' then
    perform public.err('409', 'Faites d’abord votre check-in.');
  end if;
  select coalesce(jsonb_agg(e) filter (where jsonb_typeof(e) = 'string'), '[]'::jsonb) into paths
    from jsonb_array_elements(case when jsonb_typeof(check_out.photos) = 'array'
                                   then check_out.photos else '[]'::jsonb end) e;
  update public.assignments x set status = 'submitted', check_out_at = now(), note = check_out.note,
      photos = paths, auto_validate_at = now() + interval '48 hours'
    where x.id = a.id returning * into a;
  return public.assignment_json(a, a.worker_id);
end $$;

create or replace function public.withdraw_assignment(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  refs record;
  a public.assignments;
begin
  select * into refs from public.my_assignment_refs(withdraw_assignment.id);
  -- Ordre des verrous : mission, puis candidature, puis affectation (revérifiée).
  perform 1 from public.missions m where m.id = refs.mission_id for update;
  perform public.settle_due();
  perform 1 from public.applications x where x.id = refs.application_id for update;
  a := public.my_assignment(withdraw_assignment.id);
  if a.status <> 'confirmed' then
    perform public.err('409', 'Impossible de se désister après le check-in.');
  end if;
  update public.assignments x set status = 'cancelled', cancelled_by = 'worker'
    where x.id = a.id returning * into a;
  update public.applications x set status = 'withdrawn' where x.id = a.application_id;
  update public.missions m set slots_free = least(m.slots_free + 1, m.slots_total) where m.id = a.mission_id;
  return public.assignment_json(a, a.worker_id);
end $$;

-- ---------------------------------------------------------------------------
-- Planification : settle_due toutes les 5 minutes (pg_cron, en tant que postgres).
-- Si pg_cron n’est pas disponible (base locale sans l’extension), la migration
-- s’applique quand même et signale l’absence de planification.
-- ---------------------------------------------------------------------------
do $$
begin
  if exists (select 1 from pg_available_extensions where name = 'pg_cron') then
    create extension if not exists pg_cron;
    perform cron.unschedule('settle-due') where exists (select 1 from cron.job where jobname = 'settle-due');
    perform cron.schedule('settle-due', '*/5 * * * *', 'select public.settle_due()');
  else
    raise notice 'pg_cron indisponible : settle-due n’est pas planifiée.';
  end if;
end $$;

-- ---------------------------------------------------------------------------
-- Droits : seules les RPC sont appelables. Les aides internes (format_fcfa, jtext,
-- jint, jfloat, jvalue, parse_instant, slot_amount_for, poster_mission_json,
-- done_missions, candidate_json, wallet_json, own_mission, poster_application_mission,
-- poster_assignment_mission, pay_assignment, settle_due) n’ont aucun droit. settle_due est appelée par pg_cron (postgres) et depuis les RPC.
-- ---------------------------------------------------------------------------
revoke all on function public.format_fcfa(bigint), public.jtext(jsonb), public.jint(jsonb),
  public.jfloat(jsonb), public.jvalue(jsonb), public.parse_instant(text),
  public.slot_amount_for(text, integer, integer), public.poster_mission_json(public.missions),
  public.done_missions(uuid, jsonb), public.candidate_json(public.applications), public.wallet_json(uuid),
  public.own_mission(text), public.poster_application_mission(text), public.poster_assignment_mission(text),
  public.pay_assignment(text), public.settle_due()
  from public, anon, authenticated;

revoke all on function public.publish_mission(jsonb), public.list_my_missions(), public.get_my_mission(text),
  public.list_candidates(text), public.offer_application(text), public.reject_application(text),
  public.validate_assignment(text), public.contest_assignment(text, text), public.cancel_mission(text),
  public.get_wallet(),
  public.list_missions(integer, text, integer, text, boolean, text, text),
  public.list_cities(), public.get_mission(text), public.get_poster(text),
  public.list_my_applications(), public.apply_to_mission(text, text), public.withdraw_application(text),
  public.confirm_offer(text), public.decline_offer(text),
  public.get_assignment(text), public.check_in(text, double precision, double precision),
  public.check_out(text, text, jsonb), public.withdraw_assignment(text),
  public.get_earnings(), public.get_payout(text)
  from public, anon;

grant execute on function public.publish_mission(jsonb), public.list_my_missions(), public.get_my_mission(text),
  public.list_candidates(text), public.offer_application(text), public.reject_application(text),
  public.validate_assignment(text), public.contest_assignment(text, text), public.cancel_mission(text),
  public.get_wallet(),
  public.list_missions(integer, text, integer, text, boolean, text, text),
  public.list_cities(), public.get_mission(text), public.get_poster(text),
  public.list_my_applications(), public.apply_to_mission(text, text), public.withdraw_application(text),
  public.confirm_offer(text), public.decline_offer(text),
  public.get_assignment(text), public.check_in(text, double precision, double precision),
  public.check_out(text, text, jsonb), public.withdraw_assignment(text),
  public.get_earnings(), public.get_payout(text)
  to authenticated;
