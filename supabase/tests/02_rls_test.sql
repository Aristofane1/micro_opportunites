begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(16);

select tests.make_user('rls-poster@test.bj') as poster \gset
select tests.make_user('rls-worker@test.bj') as worker \gset
select tests.make_user('rls-other@test.bj') as other \gset

-- Données préparées en tant que postgres.
insert into public.wallets (poster_id, balance) values (:'poster', 1000);
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-rls', :'poster', 'Test', 'Manutention', 'Cotonou', 6.36, 2.42, now() + interval '1 day',
  60, 5000, 5000, 1, 1, now() + interval '12 hours');
insert into public.alerts (owner_id, zone, days) values (:'other', 'Cotonou', 'Lun');

select tests.login_as(:'worker');

-- Écritures directes interdites (Review focus 1).
select throws_ok(format($$ insert into public.wallets (poster_id, balance) values (%L, 999999) $$, :'worker'),
  '42501', null, 'insert wallets refusé');
select throws_ok(format($$ insert into public.payouts (id, worker_id, amount, gross_amount, mission_title,
    poster_name, validated_at, account_label, reference) values ('p-x', %L, 1, 1, 't', 'p', now(), 'a', 'r') $$, :'worker'),
  '42501', null, 'insert payouts refusé');
select throws_ok(format($$ insert into public.assignments (mission_id, application_id, worker_id, status, pay_amount)
    values ('m-rls', 'a-x', %L, 'paid', 5000) $$, :'worker'),
  '42501', null, 'insert assignments refusé');
select throws_ok(format($$ insert into public.profiles (id) values (%L) $$, gen_random_uuid()),
  '42501', null, 'insert profiles refusé');
with u as (update public.missions set pay_amount = 1 where id = 'm-rls' returning 1)
  select is(count(*)::int, 0, 'update missions sans effet') from u;
with u as (update public.wallets set balance = 0 returning 1)
  select is(count(*)::int, 0, 'update wallets sans effet') from u;
with u as (update public.profiles set kyc_status = 'verified' returning 1)
  select is(count(*)::int, 0, 'update de son propre kyc_status sans effet') from u;
with u as (delete from public.alerts returning 1)
  select is(count(*)::int, 0, 'delete alerts sans effet') from u;

-- Lectures directes : seulement soi.
select is((select count(*)::int from public.profiles), 1, 'ne voit que son profil');
select is((select count(*)::int from public.alerts), 0, 'ne voit pas les alertes d’autrui');
select is((select count(*)::int from public.wallets), 0, 'portefeuilles invisibles');
select is((select count(*)::int from public.profiles_private), 0, 'données privées invisibles');

-- Droits d’exécution (aides internes non appelables, défauts révoqués).
select throws_ok($$ select public.handle_new_user() $$, '42501', null, 'handle_new_user non appelable');
select throws_ok($$ select public.account_json(null::public.profiles) $$, '42501', null, 'account_json non appelable');
select throws_ok($$ select public.err('422', 'x') $$, '42501', null, 'err non appelable');
reset role;
create function public.tmp_default_acl() returns int language sql as $$ select 1 $$;
select ok(not has_function_privilege('authenticated', 'public.tmp_default_acl()', 'execute')
  and not has_function_privilege('anon', 'public.tmp_default_acl()', 'execute'),
  'nouvelle fonction : aucun droit par défaut');

select * from finish();
rollback;
