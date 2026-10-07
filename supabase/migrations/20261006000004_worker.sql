-- Côté exécutant : missions (liste, carte, détail), profil d’annonceur, candidatures,
-- affectations et gains. Les règles, les messages et le JSON reprennent ceux du faux
-- serveur. Les données des autres utilisateurs ne sortent que par ces fonctions, en
-- JSON choisi ; l’adresse exacte (mission_locations) n’est donnée qu’à l’exécutant de
-- l’affectation (get_assignment).
--
-- Ordre des verrous (règle pour toutes les fonctions, Task 4 comprise) :
-- mission, puis candidature, puis affectation. Une fonction qui doit verrouiller une
-- candidature ou une affectation et aussi sa mission lit d’abord l’identifiant de la
-- mission sans verrou, verrouille la mission (for update), puis verrouille et revérifie
-- la candidature ou l’affectation.

-- Centres des villes (carte des villes), mêmes valeurs que le faux serveur.
insert into public.cities (name, lat, lng) values
  ('Abomey-Calavi', 6.4600, 2.3400),
  ('Cotonou', 6.3703, 2.3912),
  ('Ouidah', 6.3667, 2.0850)
on conflict (name) do update set lat = excluded.lat, lng = excluded.lng;

-- ---------------------------------------------------------------------------
-- Aides internes (aucun droit d’exécution pour les clients).
-- ---------------------------------------------------------------------------

-- Distance en km entre deux points (formule de haversine).
create or replace function public.distance_km(lat1 double precision, lng1 double precision,
  lat2 double precision, lng2 double precision) returns double precision
language sql immutable as $$
  select 6371.0 * 2 * atan2(sqrt(a), sqrt(1 - a))
  from (select power(sin(radians(lat2 - lat1) / 2), 2)
             + cos(radians(lat1)) * cos(radians(lat2)) * power(sin(radians(lng2 - lng1) / 2), 2) as a) s
$$;

-- Profil public de l’annonceur (vide si l’utilisateur n’a jamais été annonceur).
create or replace function public.poster_public(poster_id uuid) returns jsonb
language sql stable as $$
  select coalesce((select p.poster_profile from public.profiles p where p.id = poster_id), '{}'::jsonb)
$$;

-- Mission telle que vue par un candidat : jamais d’adresse ni de zone.
-- Le montant affiché est celui versé à une personne (slot_amount).
create or replace function public.public_mission_json(m public.missions, viewer uuid) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'id', m.id,
    'title', m.title,
    'category', m.category,
    'city', m.city,
    'startAt', public.iso(m.start_at),
    'durationMin', m.duration_min,
    'pay', jsonb_build_object('amount', m.slot_amount, 'type', 'flat'),
    'slotsTotal', m.slots_total,
    'slotsFree', m.slots_free,
    'description', m.description,
    'applyDeadline', public.iso(m.apply_deadline),
    'publishedAt', public.iso(m.published_at),
    'status', m.status,
    'poster', jsonb_build_object(
      'id', m.poster_id,
      'displayName', pp->'displayName',
      'initials', pp->'initials',
      'verified', pp->'verified',
      'rating', pp->'rating',
      'avgValidationHours', pp->'avgValidationHours'),
    'publicQuestionsCount', m.public_questions_count,
    'alreadyApplied', exists (
      select 1 from public.applications a
      where a.mission_id = m.id and a.worker_id = viewer and a.status <> 'withdrawn'))
  from (select public.poster_public(m.poster_id) as pp) s
$$;

create or replace function public.application_json(a public.applications) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'id', a.id,
    'missionId', a.mission_id,
    'status', a.status,
    'message', a.message,
    'createdAt', public.iso(a.created_at),
    'offerExpiresAt', public.iso(a.offer_expires_at),
    'assignmentId', a.assignment_id,
    'mission', jsonb_build_object(
      'title', m.title,
      'city', m.city,
      'startAt', public.iso(m.start_at),
      'durationMin', m.duration_min,
      'payAmount', m.slot_amount,
      'posterName', pp->'displayName',
      'posterRating', pp->'rating',
      'posterVerified', pp->'verified'))
  from public.missions m, lateral (select public.poster_public(m.poster_id) as pp) s
  where m.id = a.mission_id
$$;

-- Affectation vue par l’exécutant retenu : adresse exacte incluse, distance et temps
-- de trajet calculés depuis sa position.
create or replace function public.assignment_json(a public.assignments, viewer uuid) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'id', a.id,
    'missionId', a.mission_id,
    'applicationId', a.application_id,
    'workerId', a.worker_id,
    'title', m.title,
    'status', a.status,
    'startAt', public.iso(m.start_at),
    'durationMin', m.duration_min,
    'payAmount', a.pay_amount,
    'city', m.city,
    'district', l.district,
    'address', l.address,
    'landmark', l.landmark,
    'lat', l.lat,
    'lng', l.lng,
    'briefing', l.briefing,
    'posterName', public.poster_public(m.poster_id)->'displayName',
    'payoutOperator', a.payout_operator,
    'checkInAt', public.iso(a.check_in_at),
    'checkInDistanceM', a.check_in_distance_m,
    'checkOutAt', public.iso(a.check_out_at),
    'note', a.note,
    'photos', a.photos,
    'autoValidateAt', public.iso(a.auto_validate_at),
    'contestReason', a.contest_reason,
    'cancelledBy', a.cancelled_by,
    'payoutId', a.payout_id,
    'distanceKm', round(d.km::numeric, 1),
    'travelMinutes', least(greatest(ceil(d.km / 15 * 60)::int, 1), 600))
  from public.missions m
  join public.mission_locations l on l.mission_id = m.id
  cross join lateral (
    select public.distance_km(p.lat, p.lng, l.lat, l.lng) as km
    from public.profiles p where p.id = viewer) d
  where m.id = a.mission_id
$$;

-- Journée au Bénin (UTC+1) d’un instant.
create or replace function public.benin_day(ts timestamptz) returns date
language sql immutable as $$
  select ((ts at time zone 'UTC') + interval '1 hour')::date
$$;

-- ---------------------------------------------------------------------------
-- Missions
-- ---------------------------------------------------------------------------

create or replace function public.list_missions(km integer default null, cat text default null,
  min integer default null, "when" text default null, multi boolean default null,
  city text default null, q text default null) returns jsonb
language plpgsql stable security definer set search_path = public as $$
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
language plpgsql stable security definer set search_path = public as $$
declare
  me uuid := public.uid();
  p public.profiles;
begin
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
language plpgsql stable security definer set search_path = public as $$
declare
  me uuid := public.uid();
  m public.missions;
begin
  select * into m from public.missions where missions.id = get_mission.id;
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return public.public_mission_json(m, me);
end $$;

create or replace function public.get_poster(id text) returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare
  pid uuid;
  pp jsonb;
begin
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

-- ---------------------------------------------------------------------------
-- Candidatures
-- ---------------------------------------------------------------------------

create or replace function public.list_my_applications() returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare me uuid := public.uid();
begin
  return coalesce((select jsonb_agg(public.application_json(a) order by a.created_at desc, a.id)
    from public.applications a where a.worker_id = me), '[]'::jsonb);
end $$;

create or replace function public.apply_to_mission(mission_id text, message text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  me uuid := public.uid();
  m public.missions;
  kyc text;
  body text := trim(coalesce(apply_to_mission.message, ''));
  a public.applications;
begin
  select * into m from public.missions where id = apply_to_mission.mission_id for update;
  if not found or m.status <> 'published' then
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

-- Mission d’une candidature de l’appelant, lue sans verrou ; 404 sinon.
create or replace function public.my_application_mission(id text) returns text
language plpgsql stable set search_path = public as $$
declare mid text;
begin
  select x.mission_id into mid from public.applications x
    where x.id = my_application_mission.id and x.worker_id = public.uid();
  if not found then
    perform public.err('404', 'Candidature introuvable.');
  end if;
  return mid;
end $$;

-- Candidature de l’appelant, verrouillée ; 404 sinon.
create or replace function public.my_application(id text) returns public.applications
language plpgsql set search_path = public as $$
declare a public.applications;
begin
  select * into a from public.applications x
    where x.id = my_application.id and x.worker_id = public.uid() for update;
  if not found then
    perform public.err('404', 'Candidature introuvable.');
  end if;
  return a;
end $$;

create or replace function public.withdraw_application(id text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare a public.applications := public.my_application(withdraw_application.id);
begin
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
  a := public.my_application(decline_offer.id);
  if a.status <> 'offered' or (a.offer_expires_at is not null and a.offer_expires_at <= now()) then
    perform public.err('409', 'Cette offre n’est plus disponible.');
  end if;
  update public.applications x set status = 'declined' where x.id = a.id returning * into a;
  return public.application_json(a);
end $$;

-- ---------------------------------------------------------------------------
-- Affectations
-- ---------------------------------------------------------------------------

-- Mission et candidature d’une affectation de l’appelant, lues sans verrou ; 404 sinon.
create or replace function public.my_assignment_refs(id text, out mission_id text, out application_id text)
language plpgsql stable set search_path = public as $$
begin
  select x.mission_id, x.application_id into my_assignment_refs.mission_id, my_assignment_refs.application_id
    from public.assignments x
    where x.id = my_assignment_refs.id and x.worker_id = public.uid();
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
end $$;

-- Affectation de l’appelant, verrouillée ; 404 sinon.
create or replace function public.my_assignment(id text) returns public.assignments
language plpgsql set search_path = public as $$
declare a public.assignments;
begin
  select * into a from public.assignments x
    where x.id = my_assignment.id and x.worker_id = public.uid() for update;
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return a;
end $$;

create or replace function public.get_assignment(id text) returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare a public.assignments;
begin
  select * into a from public.assignments x
    where x.id = get_assignment.id and x.worker_id = public.uid();
  if not found then
    perform public.err('404', 'Mission introuvable.');
  end if;
  return public.assignment_json(a, a.worker_id);
end $$;

create or replace function public.check_in(id text, lat double precision, lng double precision) returns jsonb
language plpgsql security definer set search_path = public as $$
declare
  a public.assignments := public.my_assignment(check_in.id);
  l public.mission_locations;
  meters integer;
begin
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
  a public.assignments := public.my_assignment(check_out.id);
  paths jsonb;
begin
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
-- Gains
-- ---------------------------------------------------------------------------

create or replace function public.payout_json(p public.payouts) returns jsonb
language sql stable as $$
  select jsonb_build_object(
    'id', p.id,
    'workerId', p.worker_id,
    'posterId', p.poster_id,
    'assignmentId', p.assignment_id,
    'amount', p.amount,
    'grossAmount', p.gross_amount,
    'missionTitle', p.mission_title,
    'posterName', p.poster_name,
    'validatedAt', public.iso(p.validated_at),
    'commissionLabel', p.commission_label,
    'accountLabel', p.account_label,
    'reference', p.reference,
    'status', p.status)
$$;

create or replace function public.get_earnings() returns jsonb
language plpgsql stable security definer set search_path = public as $$
declare
  me uuid := public.uid();
  upcoming_amount integer;
  upcoming_count integer;
  paid_amount integer;
  paid_count integer;
  lines jsonb;
begin
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
language plpgsql stable security definer set search_path = public as $$
declare p public.payouts;
begin
  select * into p from public.payouts x where x.id = get_payout.id and x.worker_id = public.uid();
  if not found then
    perform public.err('404', 'Reçu introuvable.');
  end if;
  return public.payout_json(p);
end $$;

-- ---------------------------------------------------------------------------
-- Droits : seules les RPC sont appelables ; les aides internes (distance_km,
-- poster_public, public_mission_json, application_json, assignment_json, benin_day,
-- my_application, my_assignment, my_application_mission, my_assignment_refs,
-- payout_json) n’ont aucun droit.
-- ---------------------------------------------------------------------------
revoke all on function public.distance_km(double precision, double precision, double precision, double precision),
  public.poster_public(uuid), public.public_mission_json(public.missions, uuid),
  public.application_json(public.applications), public.assignment_json(public.assignments, uuid),
  public.benin_day(timestamptz), public.my_application(text), public.my_assignment(text),
  public.my_application_mission(text), public.my_assignment_refs(text), public.payout_json(public.payouts)
  from public, anon, authenticated;

revoke all on function public.list_missions(integer, text, integer, text, boolean, text, text),
  public.list_cities(), public.get_mission(text), public.get_poster(text),
  public.list_my_applications(), public.apply_to_mission(text, text), public.withdraw_application(text),
  public.confirm_offer(text), public.decline_offer(text),
  public.get_assignment(text), public.check_in(text, double precision, double precision),
  public.check_out(text, text, jsonb), public.withdraw_assignment(text),
  public.get_earnings(), public.get_payout(text)
  from public, anon;

grant execute on function public.list_missions(integer, text, integer, text, boolean, text, text),
  public.list_cities(), public.get_mission(text), public.get_poster(text),
  public.list_my_applications(), public.apply_to_mission(text, text), public.withdraw_application(text),
  public.confirm_offer(text), public.decline_offer(text),
  public.get_assignment(text), public.check_in(text, double precision, double precision),
  public.check_out(text, text, jsonb), public.withdraw_assignment(text),
  public.get_earnings(), public.get_payout(text)
  to authenticated;
