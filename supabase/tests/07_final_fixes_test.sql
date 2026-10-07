begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(55);

-- Montant disponible et solde du portefeuille, lus en tant que postgres.
create or replace function tests.available(poster uuid) returns integer language sql as $$
  select (public.wallet_json(poster)->>'available')::int
$$;
create or replace function tests.blocked(mission text) returns integer language sql as $$
  select coalesce((select amount from public.blocked_funds where mission_id = mission), 0)
$$;
create or replace function tests.wallet_balance(poster uuid) returns integer language sql as $$
  select balance from public.wallets where poster_id = poster
$$;

select tests.make_user('ff-poster@test.bj') as poster \gset
select tests.make_user('ff-worker-a@test.bj') as wa \gset
select tests.make_user('ff-worker-b@test.bj') as wb \gset
select tests.make_user('ff-worker-c@test.bj') as wc \gset

update public.profiles set first_name = 'Adjovi', last_name = 'H.' where id = :'poster';
select tests.login_as(:'poster');
select public.set_role('poster');
reset role;
update public.wallets set balance = 100000 where poster_id = :'poster';
update public.profiles set kyc_status = 'pending', lat = 6.4485, lng = 2.3557
  where id in (:'wa', :'wb', :'wc');

-- ---------------------------------------------------------------------------
-- Mission commencée : plus d’offre ni de confirmation
-- ---------------------------------------------------------------------------
-- S1 : 3 places à 5 000, une confirmée (A), une candidature en attente (B), une offre (C).
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-ff-s1', :'poster', 'Mission commencée', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() - interval '1 hour', 60, 5000, 5000, 3, 2, now() - interval '2 hours');
insert into public.mission_locations (mission_id, lat, lng) values ('m-ff-s1', 6.449, 2.356);
insert into public.blocked_funds (mission_id, poster_id, amount) values ('m-ff-s1', :'poster', 15000);
insert into public.applications (id, mission_id, worker_id, status, assignment_id, offer_expires_at) values
  ('a-ff-s1-a', 'm-ff-s1', :'wa', 'confirmed', 'as-ff-s1-a', null),
  ('a-ff-s1-b', 'm-ff-s1', :'wb', 'pending', null, null),
  ('a-ff-s1-c', 'm-ff-s1', :'wc', 'offered', null, now() + interval '5 hours');
insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount)
values ('as-ff-s1-a', 'm-ff-s1', 'a-ff-s1-a', :'wa', 'confirmed', 5000);

select tests.login_as(:'poster');
select throws_ok($$ select public.offer_application('a-ff-s1-b') $$, 'MO409',
  'La mission a déjà commencé.', 'offre refusée une fois la mission commencée');
select tests.login_as(:'wc');
select throws_ok($$ select public.confirm_offer('a-ff-s1-c') $$, 'MO409',
  'La mission a déjà commencé.', 'confirmation refusée une fois la mission commencée');

-- ---------------------------------------------------------------------------
-- Clôture du recrutement au début de la mission (settle_due)
-- ---------------------------------------------------------------------------
reset role;
-- S2 : aucune affectation, 2 places à 4 000 bloquées, une candidature en attente.
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-ff-s2', :'poster', 'Mission sans personne', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() - interval '1 hour', 60, 4000, 4000, 2, 2, now() - interval '2 hours');
insert into public.blocked_funds (mission_id, poster_id, amount) values ('m-ff-s2', :'poster', 8000);
insert into public.applications (id, mission_id, worker_id, status) values ('a-ff-s2-b', 'm-ff-s2', :'wb', 'pending');

select tests.wallet_balance(:'poster') as bal0, tests.available(:'poster') as avail0 \gset
select public.settle_due();

select is((select status from public.applications where id = 'a-ff-s1-b'), 'rejected',
  'clôture : candidature en attente refusée');
select is((select status from public.applications where id = 'a-ff-s1-c'), 'expired',
  'clôture : offre en cours expirée');
select is((select status from public.assignments where id = 'as-ff-s1-a'), 'confirmed',
  'clôture : affectation confirmée gardée');
select is((select (status, slots_free)::text from public.missions where id = 'm-ff-s1'), '(filled,0)',
  'clôture : mission partiellement pourvue close');
select is(tests.blocked('m-ff-s1'), 5000, 'clôture : seules les places pourvues restent bloquées');
select is((select status from public.missions where id = 'm-ff-s2'), 'cancelled',
  'clôture : mission sans affectation annulée');
select is((select count(*)::int from public.blocked_funds where mission_id = 'm-ff-s2'), 0,
  'clôture : montant bloqué de la mission annulée libéré');
select is((select status from public.applications where id = 'a-ff-s2-b'), 'rejected',
  'clôture : candidature de la mission annulée refusée');
select is(tests.wallet_balance(:'poster'), :bal0, 'clôture : solde inchangé');
select is(tests.available(:'poster'), :avail0 + 10000 + 8000, 'clôture : disponible augmenté du montant libéré');

select public.settle_due();
select is(tests.blocked('m-ff-s1'), 5000, 'clôture idempotente : montant bloqué inchangé');
select is(tests.wallet_balance(:'poster'), :bal0, 'clôture idempotente : solde inchangé');
select is(tests.available(:'poster'), :avail0 + 18000, 'clôture idempotente : disponible inchangé');
select is((select status from public.missions where id = 'm-ff-s2'), 'cancelled',
  'clôture idempotente : mission annulée inchangée');

-- Désistement après la clôture : la place libérée est débloquée au règlement suivant ;
-- sans plus aucune affectation, la mission est annulée.
select tests.login_as(:'wa');
select is((public.withdraw_assignment('as-ff-s1-a')->>'status'), 'cancelled', 'désistement après clôture');
reset role;
select public.settle_due();
select is((select status from public.missions where id = 'm-ff-s1'), 'cancelled',
  'plus aucune affectation : mission annulée');
select is(tests.blocked('m-ff-s1'), 0, 'place désistée débloquée');
select is(tests.available(:'poster'), :avail0 + 23000, 'disponible augmenté de la place désistée');
select is(tests.wallet_balance(:'poster'), :bal0, 'solde toujours inchangé');

-- ---------------------------------------------------------------------------
-- Mission terminée : toutes les affectations terminales, au moins une payée
-- ---------------------------------------------------------------------------
-- S3 : 2 places à 5 000, une seule pourvue, travail soumis et échu.
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-ff-s3', :'poster', 'Mission à moitié pourvue', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() - interval '3 days', 60, 5000, 5000, 2, 1, now() - interval '4 days');
insert into public.mission_locations (mission_id, lat, lng) values ('m-ff-s3', 6.449, 2.356);
insert into public.blocked_funds (mission_id, poster_id, amount) values ('m-ff-s3', :'poster', 10000);
insert into public.applications (id, mission_id, worker_id, status, assignment_id)
values ('a-ff-s3-b', 'm-ff-s3', :'wb', 'confirmed', 'as-ff-s3-b');
insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount, auto_validate_at)
values ('as-ff-s3-b', 'm-ff-s3', 'a-ff-s3-b', :'wb', 'submitted', 5000, now() - interval '1 minute');

select tests.wallet_balance(:'poster') as bal1, tests.available(:'poster') as avail1 \gset
select public.settle_due();
select is((select status from public.assignments where id = 'as-ff-s3-b'), 'paid', 'travail échu versé');
select is(tests.wallet_balance(:'poster'), :bal1 - 5000, 'solde débité du seul versement');
select is(tests.blocked('m-ff-s3'), 0, 'place vide et place versée débloquées');
select is(tests.available(:'poster'), :avail1 + 5000, 'disponible augmenté de la place vide');
select tests.login_as(:'poster');
select is((public.get_my_mission('m-ff-s3')->>'status'), 'completed',
  'mission terminée sans être complète');
select is((select m->>'status' from jsonb_array_elements(public.list_my_missions()) m where m->>'id' = 'm-ff-s3'),
  'completed', 'Mes missions : terminée');
select isnt((select m->>'status' from jsonb_array_elements(public.list_my_missions()) m where m->>'id' = 'm-ff-s2'),
  'completed', 'Mes missions : mission annulée non terminée');

-- Payée avant le début : pas encore terminée (le recrutement n’est pas clos).
reset role;
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-ff-early', :'poster', 'Payée en avance', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() + interval '1 day', 60, 5000, 5000, 2, 1, now() + interval '12 hours');
insert into public.blocked_funds (mission_id, poster_id, amount) values ('m-ff-early', :'poster', 5000);
insert into public.applications (id, mission_id, worker_id, status, assignment_id)
values ('a-ff-early', 'm-ff-early', :'wa', 'confirmed', 'as-ff-early');
insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount)
values ('as-ff-early', 'm-ff-early', 'a-ff-early', :'wa', 'paid', 5000);
select tests.login_as(:'poster');
select isnt((public.get_my_mission('m-ff-early')->>'status'), 'completed',
  'une place payée avant le début : pas terminée');

-- ---------------------------------------------------------------------------
-- Clôture avec des affectations actives : seules les places libres sont débloquées
-- ---------------------------------------------------------------------------
reset role;
-- S4 : 4 places à 5 000, une affectation contestée, une en cours, 2 places libres.
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-ff-s4', :'poster', 'Mission en cours', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() - interval '2 hours', 240, 5000, 5000, 4, 2, now() - interval '3 hours');
insert into public.blocked_funds (mission_id, poster_id, amount) values ('m-ff-s4', :'poster', 20000);
insert into public.applications (id, mission_id, worker_id, status, assignment_id) values
  ('a-ff-s4-a', 'm-ff-s4', :'wa', 'confirmed', 'as-ff-s4-a'),
  ('a-ff-s4-b', 'm-ff-s4', :'wb', 'confirmed', 'as-ff-s4-b'),
  ('a-ff-s4-c', 'm-ff-s4', :'wc', 'pending', null);
insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount,
  check_in_at, check_out_at, contest_reason) values
  ('as-ff-s4-a', 'm-ff-s4', 'a-ff-s4-a', :'wa', 'contested', 5000, now() - interval '2 hours',
    now() - interval '1 hour', 'Travail incomplet'),
  ('as-ff-s4-b', 'm-ff-s4', 'a-ff-s4-b', :'wb', 'in_progress', 5000, now() - interval '2 hours', null, null);
select tests.wallet_balance(:'poster') as bal4, tests.available(:'poster') as avail4 \gset
select public.settle_due();
select is(tests.blocked('m-ff-s4'), 10000, 'clôture : contestée et en cours restent bloquées');
select is((select string_agg(id || ':' || status, ',' order by id) from public.assignments where mission_id = 'm-ff-s4'),
  'as-ff-s4-a:contested,as-ff-s4-b:in_progress', 'clôture : affectations actives inchangées');
select is((select (status, slots_free)::text from public.missions where id = 'm-ff-s4'), '(filled,0)',
  'clôture : mission en cours close');
select is((select status from public.applications where id = 'a-ff-s4-c'), 'rejected',
  'clôture : candidature en attente refusée');
select is(tests.wallet_balance(:'poster'), :bal4, 'clôture : solde inchangé');
select is(tests.available(:'poster'), :avail4 + 10000, 'clôture : seules les places libres débloquées');
select public.settle_due();
select is(tests.blocked('m-ff-s4'), 10000, 'clôture idempotente avec affectations actives');

-- ---------------------------------------------------------------------------
-- Date limite de candidature
-- ---------------------------------------------------------------------------
reset role;
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline, published_at)
values ('m-ff-late', :'poster', 'Candidatures closes', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() + interval '2 days', 60, 3000, 3000, 1, 1, now() - interval '1 minute', now() - interval '1 hour'),
  ('m-ff-open', :'poster', 'Candidatures ouvertes', 'other', 'Abomey-Calavi', 6.45, 2.355,
  now() + interval '2 days', 60, 3000, 3000, 1, 1, now() + interval '1 day', now() - interval '2 hours'),
  ('m-ff-far', :'poster', 'Mission à Ouidah', 'other', 'Ouidah', 6.3667, 2.085,
  now() + interval '2 days', 60, 3000, 3000, 1, 1, now() + interval '1 day', now() - interval '3 hours');
select tests.wallet_balance(:'poster') as bal2, tests.available(:'poster') as avail2 \gset

select tests.login_as(:'wb');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,null,null)->'items',
  '{m-ff-late,m-ff-open}'), array['m-ff-open'], 'Explorer : candidatures closes masquées');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,'Abomey-Calavi',null)->'items',
  '{m-ff-late,m-ff-open}'), array['m-ff-open'], 'Explorer par ville : candidatures closes masquées');
select throws_ok($$ select public.apply_to_mission('m-ff-late', '') $$, 'MO409',
  'Les candidatures sont closes pour cette mission.', 'candidature après la date limite refusée');
select is((public.apply_to_mission('m-ff-open', '')->>'status'), 'pending', 'candidature avant la date limite');
select throws_ok($$ select public.apply_to_mission('m-ff-s3', '') $$, 'MO404',
  'Cette mission n’est plus disponible.', 'candidature à une mission commencée refusée');

-- ---------------------------------------------------------------------------
-- Position de l’appareil pour Explorer
-- ---------------------------------------------------------------------------
select is(tests.ids_of(public.list_missions(5,null,null,'all',false,null,null)->'items', '{m-ff-far}'),
  '{}'::text[], 'sans position : rayon autour du profil');
select is(tests.ids_of(public.list_missions(km => 5, lat => 6.3667, lng => 2.085)->'items', '{m-ff-far,m-ff-open}'),
  array['m-ff-far'], 'position de l’appareil : rayon autour de l’appareil');
select is(tests.ids_of(public.list_missions(km => 5, lat => 6.3667)->'items', '{m-ff-far}'),
  '{}'::text[], 'position incomplète : rayon autour du profil');
select is(tests.ids_of(public.list_missions(km => 5, city => 'Abomey-Calavi', lat => 6.3667, lng => 2.085)->'items',
  '{m-ff-far,m-ff-open}'), array['m-ff-open'], 'ville choisie : position ignorée');
select is((public.list_missions(km => 5, lat => 6.3667, lng => 2.085)->>'radiusKm')::int, 5, 'rayon renvoyé');

reset role;
select is(tests.wallet_balance(:'poster'), :bal2, 'Explorer : solde inchangé');

-- ---------------------------------------------------------------------------
-- Pièce d’identité : selfie manquant
-- ---------------------------------------------------------------------------
select tests.login_as(:'wc');
select throws_ok(format($$ select public.submit_kyc('id_card','BJ', %L, %L, null) $$,
    :'wc' || '/k/front.jpg', :'wc' || '/k/back.jpg'),
  'MO422', 'Prenez un selfie pour vérifier votre identité.', 'selfie manquant (carte)');
select throws_ok(format($$ select public.submit_kyc('passport','BJ', %L, null, '') $$, :'wc' || '/k/front.jpg'),
  'MO422', 'Prenez un selfie pour vérifier votre identité.', 'selfie manquant (passeport)');
select throws_ok(format($$ select public.submit_kyc('id_card','BJ', %L, null, %L) $$,
    :'wc' || '/k/front.jpg', :'wc' || '/k/selfie.jpg'),
  'MO422', 'Photographiez le recto et le verso.', 'verso manquant');
select throws_ok(format($$ select public.submit_kyc('id_card','BJ', null, %L, null) $$, :'wc' || '/k/back.jpg'),
  'MO422', 'Photographiez le recto et le verso.', 'recto manquant (avant le selfie)');
select throws_ok(format($$ select public.submit_kyc('passport','BJ', %L, null, %L) $$,
    :'wc' || '/k/front.jpg', :'wb' || '/k/selfie.jpg'),
  'MO422', 'Prenez un selfie pour vérifier votre identité.', 'selfie hors du dossier de l’utilisateur');
select is((public.submit_kyc('passport','BJ', :'wc' || '/k/front.jpg', null, :'wc' || '/k/selfie.jpg')->>'status'),
  'pending', 'pièce complète acceptée');

-- ---------------------------------------------------------------------------
-- Droits d’exécution : exactement les RPC de l’app
-- ---------------------------------------------------------------------------
reset role;
-- Liste des RPC appelées par l’app : lib/app/backend/supabase_routes.dart (champ rpc:).
-- À tenir à jour avec ce fichier. S’y ajoutent les deux fonctions des policies du
-- bucket « proofs » (20261006000003_security.sql), évaluées en tant que « authenticated ».
select is(
  (select array_agg(p.proname::text order by p.proname::text)
     from pg_proc p join pg_namespace n on n.oid = p.pronamespace
     where n.nspname = 'public' and has_function_privilege('authenticated', p.oid, 'execute')),
  (select array_agg(x order by x) from unnest(array[
    'save_profile', 'submit_kyc', 'get_kyc', 'set_role', 'me',
    'list_my_missions', 'get_my_mission', 'get_wallet',
    'list_missions', 'list_cities', 'get_mission', 'list_candidates', 'get_poster',
    'publish_mission', 'cancel_mission', 'apply_to_mission', 'list_my_applications',
    'withdraw_application', 'confirm_offer', 'decline_offer', 'offer_application', 'reject_application',
    'get_assignment', 'check_in', 'check_out', 'withdraw_assignment', 'validate_assignment',
    'contest_assignment', 'get_earnings', 'get_payout', 'list_alerts', 'create_alert', 'delete_alert',
    -- Policies Storage :
    'can_upload_proof', 'can_read_proof']) x),
  'authenticated n’exécute que les RPC de l’app et les fonctions des policies');
select is(
  (select count(*)::int from pg_proc p join pg_namespace n on n.oid = p.pronamespace
     where n.nspname = 'public' and has_function_privilege('anon', p.oid, 'execute')),
  0, 'anon n’exécute aucune fonction');

select * from finish();
rollback;
