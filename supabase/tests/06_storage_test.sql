begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(9);

select tests.make_user('st-poster@test.bj') as poster \gset
select tests.make_user('st-worker@test.bj') as worker \gset
select tests.make_user('st-other@test.bj') as other \gset

-- Données préparées en tant que postgres.
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-st', :'poster', 'Test', 'Manutention', 'Cotonou', 6.36, 2.42, now() + interval '1 day',
  60, 5000, 5000, 2, 0, now() + interval '12 hours');
insert into public.applications (id, mission_id, worker_id, status) values ('ap-st', 'm-st', :'worker', 'confirmed');
insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount) values
  ('as-run', 'm-st', 'ap-st', :'worker', 'in_progress', 5000),
  ('as-sub', 'm-st', 'ap-st', :'worker', 'submitted', 5000);

-- Dépôts.
select tests.login_as(:'worker');
select lives_ok($$ insert into storage.objects (bucket_id, name) values ('proofs', 'as-run/proof_0.jpg') $$,
  'l’exécutant dépose une preuve en cours de mission');
select throws_ok($$ insert into storage.objects (bucket_id, name) values ('proofs', 'as-sub/proof_0.jpg') $$,
  '42501', null, 'dépôt refusé après soumission');
select lives_ok(format($$ insert into storage.objects (bucket_id, name) values ('kyc', %L) $$, :'worker' || '/c1/front.jpg'),
  'dépôt KYC dans son dossier');
select throws_ok(format($$ insert into storage.objects (bucket_id, name) values ('kyc', %L) $$, :'other' || '/c1/front.jpg'),
  '42501', null, 'dépôt KYC hors de son dossier refusé');
select tests.login_as(:'other');
select throws_ok($$ insert into storage.objects (bucket_id, name) values ('proofs', 'as-run/proof_1.jpg') $$,
  '42501', null, 'dépôt refusé à un inconnu');

-- Lectures.
select tests.login_as(:'worker');
select is((select count(*)::int from storage.objects where bucket_id = 'proofs'), 1, 'l’exécutant voit la preuve');
select is((select count(*)::int from storage.objects where bucket_id = 'kyc'), 0, 'KYC illisible par son propriétaire');
select tests.login_as(:'poster');
select is((select count(*)::int from storage.objects where bucket_id = 'proofs'), 1, 'l’annonceur voit la preuve');
select tests.login_as(:'other');
select is((select count(*)::int from storage.objects where bucket_id = 'proofs'), 0, 'un inconnu ne voit pas la preuve');

select * from finish();
rollback;
