begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(48);

-- Solde du portefeuille, lu en tant que postgres.
create or replace function tests.balance(poster uuid) returns integer language sql as $$
  select balance from public.wallets where poster_id = poster
$$;

-- Comptes de démo (les vrais sont créés par seed.mjs via l’API admin).
select tests.make_user('s-executant@test.bj') as u1 \gset
select tests.make_user('s-executant2@test.bj') as u2 \gset
select tests.make_user('s-ganiou@test.local') as u3 \gset
select tests.make_user('s-annonceur@test.bj') as u10 \gset
select tests.make_user('s-p1@test.local') as p1 \gset
select tests.make_user('s-p2@test.local') as p2 \gset
select tests.make_user('s-p3@test.local') as p3 \gset
select tests.make_user('s-other@test.bj') as other \gset

select jsonb_build_object('executant', :'u1', 'executant2', :'u2', 'ganiou', :'u3', 'annonceur', :'u10',
  'p1', :'p1', 'p2', :'p2', 'p3', :'p3')::text as accounts \gset

-- Donnée d’un autre utilisateur : jamais touchée par le reset.
insert into public.alerts (id, owner_id, zone, days) values ('other-alert', :'other', 'Cotonou', 'Tous les jours');

-- Premier passage (en tant que postgres).
select is(public.seed_demo(:'accounts'::jsonb, true),
  '{"missions": 17, "applications": 9, "assignments": 2, "payouts": 6}'::jsonb,
  'seed_demo écrit 17 missions, 9 candidatures, 2 affectations, 6 versements');

-- Missions
select is((select count(*)::int from public.missions where poster_id in (:'p1', :'p2', :'p3', :'u10')), 17,
  '17 missions de démo (m1–m15, m20, m21)');
select is((select count(*)::int from public.mission_locations
  where mission_id in (select id from public.missions where poster_id in (:'p1', :'p2', :'p3', :'u10'))), 17,
  'une adresse exacte par mission');
select is((select poster_id from public.missions where id = 'm20'), :'u10'::uuid, 'm20 appartient à l’annonceur');
select is((select poster_id from public.missions where id = 'm21'), :'u10'::uuid, 'm21 appartient à l’annonceur');
select is((select poster_id from public.missions where id = 'm1'), :'p1'::uuid, 'm1 appartient à p1');
select is((select (slot_amount, pay_amount, pay_unit, slots_total, slots_free, public_questions_count)::text
  from public.missions where id = 'm1'), '(5000,5000,flat,5,3,2)', 'm1 : montants et places');
select is((select start_at from public.missions where id = 'm1'),
  (public.benin_day(now())::timestamp + interval '4 days 7 hours') at time zone 'UTC',
  'm1 : J+4 à 8 h, heure du Bénin');
select is((select apply_deadline from public.missions where id = 'm13'),
  (public.benin_day(now())::timestamp + interval '-1 day 17 hours') at time zone 'UTC',
  'm13 : date limite la veille à 18 h, heure du Bénin');
select is((select status from public.missions where id = 'm13'), 'filled', 'm13 complète');
select is((select status from public.missions where id = 'm15'), 'expired', 'm15 expirée');
select is((select (district, landmark, briefing)::text from public.mission_locations where mission_id = 'm2'),
  '(Tankpè,"Maison à portail noir après la boulangerie. Demandez Koffi.","Portable HP · clé USB fournie")',
  'm2 : adresse exacte');

-- Portefeuille de l’annonceur
select is(tests.balance(:'u10'), 200000, 'solde de l’annonceur : 200 000');
select is((select amount from public.blocked_funds where mission_id = 'm20'), 12000, 'm20 : 12 000 bloqués');
select is((select amount from public.blocked_funds where mission_id = 'm21'), 8000, 'm21 : 8 000 bloqués');

-- Candidatures et affectations
select is((select string_agg(id || ':' || status, ',' order by id) from public.applications where worker_id = :'u1'),
  'a1:offered,a2:confirmed,a3:pending,a4:pending_sync,a5:rejected,a6:expired',
  'candidatures de l’exécutant de démo');
select ok((select offer_expires_at between now() + interval '10 hours 59 minutes' and now() + interval '11 hours'
  from public.applications where id = 'a1'), 'a1 : offre valable 11 h');
select is((select (worker_id, status)::text from public.applications where id = 'a21'),
  format('(%s,pending)', :'u3'), 'a21 : Ganiou en attente sur m20');
select is((select (status, pay_amount, application_id)::text from public.assignments where id = 'as1'),
  '(confirmed,5000,a2)', 'as1 confirmée');
select is((select (worker_id, status, check_in_distance_m, photos::text)::text from public.assignments where id = 'm21'),
  format('(%s,submitted,35,"[""p1.jpg"", ""p2.jpg""]")', :'u2'), 'm21 soumise par Sènami');
select ok((select auto_validate_at > now() + interval '46 hours' from public.assignments where id = 'm21'),
  'm21 : paiement automatique dans 47 h');

-- Le règlement ne verse rien tout de suite.
select public.settle_due();
select is((select status from public.assignments where id = 'm21'), 'submitted', 'settle_due ne paie pas m21');
select is((select status from public.applications where id = 'a1'), 'offered', 'settle_due n’expire pas a1');

-- Versements, avis, alertes
select is((select count(*)::int from public.payouts where worker_id = :'u1'), 6, '6 versements de l’exécutant');
select is((select (amount, reference, account_label)::text from public.payouts where id = 'po1'),
  '(7500,MO-2026-004812,"MTN MoMo · •• 45")', 'po1');
select is((select count(*)::int from public.poster_reviews where poster_id = :'p1'), 2, 'p1 : 2 avis');
select is((select string_agg(id, ',' order by created_at) from public.alerts where owner_id = :'u1'),
  'al1,al2,al3', 'alertes al1–al3 dans l’ordre');

-- Profils
select is((select kyc_status from public.profiles where id = :'u1'), 'verified', 'exécutant de démo vérifié');
select is((select (first_name, last_name, active_role)::text from public.profiles where id = :'u1'),
  '(Rodrigue,K.,worker)', 'profil de Rodrigue');
select is((select worker_profile->'doneMissions' from public.profiles where id = :'u1'),
  '[{"category": "flyers", "count": 6}, {"category": "computer", "count": 4}]'::jsonb, 'doneMissions de u1');
select is((select worker_profile->'lastReview'->>'author' from public.profiles where id = :'u2'),
  'Cabinet Hounkpè', 'lastReview de u2');
select is((select poster_profile->>'displayName' from public.profiles where id = :'p3'), 'Chantal A.',
  'profil d’annonceur de p3');

-- Vu par l’application
-- Les 7 missions publiées à moins de 5 km, sauf celles dont la date limite de
-- candidature est passée selon l’heure du seed (m7 : 13 h, heure du Bénin).
select count(*)::int as open_near from public.missions
  where id in ('m1', 'm2', 'm5', 'm6', 'm7', 'm8', 'm11') and apply_deadline > now() \gset
select tests.login_as(:'u1');
select is(public.me()->>'firstName', 'Rodrigue', 'me() : Rodrigue');
select is((select count(*)::int from jsonb_array_elements(public.list_missions(null, null, null, null, null, null, null)->'items') i
  where i->'poster'->>'id' in (:'p1', :'p2', :'p3', :'u10')),
  :open_near,
  'list_missions (5 km) : missions ouvertes aux candidatures');
select is(jsonb_array_length(public.list_my_applications()), 6, 'Mes candidatures : 6');
select is((public.get_earnings()->'paid'->>'count')::int, 6, 'gains : 6 versements sur 30 jours');
select is(jsonb_array_length(public.get_poster(:'p1')->'reviews'), 2, 'get_poster(p1) : 2 avis');
select tests.login_as(:'u10');
select is(jsonb_array_length(public.list_candidates('m20')), 2, 'm20 : 2 candidats');
select is((public.get_wallet()->>'available')::int, 180000, 'portefeuille : 180 000 disponibles');

-- Réservée à service_role
select tests.login_as(:'u1');
select throws_ok(format('select public.seed_demo(%L::jsonb, false)', :'accounts'), '42501', null,
  'authenticated ne peut pas appeler seed_demo');
select tests.as_anon();
select throws_ok(format('select public.seed_demo(%L::jsonb, false)', :'accounts'), '42501', null,
  'anon ne peut pas appeler seed_demo');
reset role;
select ok(has_function_privilege('service_role', 'public.seed_demo(jsonb, boolean)', 'execute'),
  'service_role peut appeler seed_demo');

-- Sans reset : rien n’est réécrit, l’état courant est conservé.
update public.missions set slots_free = 1 where id = 'm1';
select is(public.seed_demo(:'accounts'::jsonb, false),
  '{"missions": 0, "applications": 0, "assignments": 0, "payouts": 0}'::jsonb,
  'second passage sans reset : rien de nouveau');
select is((select slots_free from public.missions where id = 'm1'), 1, 'sans reset, l’état courant est gardé');

-- Avec reset : état initial, données des autres intactes.
update public.wallets set balance = 5 where poster_id = :'u10';
select is(public.seed_demo(:'accounts'::jsonb, true),
  '{"missions": 17, "applications": 9, "assignments": 2, "payouts": 6}'::jsonb,
  'reset : tout est réécrit');
select is((select (slots_free, tests.balance(:'u10'))::text from public.missions where id = 'm1'),
  '(3,200000)', 'reset : état initial restauré');
select is((select count(*)::int from public.alerts where id = 'other-alert'), 1,
  'reset : alerte d’un autre utilisateur intacte');

select throws_ok(format('select public.seed_demo(%L::jsonb, true)',
  (:'accounts'::jsonb - 'p3')::text), 'P0001', 'seed_demo : compte « p3 » manquant.',
  'un compte manquant est refusé');

select * from finish();
rollback;
