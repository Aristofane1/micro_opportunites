begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(54);

select tests.make_user('w-poster@test.bj') as poster \gset
select tests.make_user('w-worker@test.bj') as worker \gset
select tests.make_user('w-worker2@test.bj') as worker2 \gset
select tests.make_user('w-nokyc@test.bj') as nokyc \gset
\set mission 'm-worker-1'
\set mission2 'm-worker-2'
\set mission3 'm-worker-far'
\set mine '''{m-worker-1,m-worker-2,m-worker-far}'''

-- L’annonceur choisit son rôle (crée son profil public).
update public.profiles set first_name = 'Adjovi', last_name = 'H.' where id = :'poster';
select tests.login_as(:'poster');
select public.set_role('poster');
reset role;

-- Données préparées en tant que postgres.
update public.profiles set kyc_status = 'pending', lat = 6.4485, lng = 2.3557
  where id in (:'worker', :'worker2');
-- Nombre de missions par ville avant les nôtres (le projet peut déjà contenir d’autres données).
select tests.login_as(:'worker');
select tests.city_count(public.list_cities(), 'Abomey-Calavi') as base_cala,
  tests.city_count(public.list_cities(), 'Ouidah') as base_ouidah \gset
reset role;
insert into public.missions (id, poster_id, title, category, description, city, zone_lat, zone_lng, start_at,
  duration_min, pay_amount, slot_amount, slots_total, slots_free, apply_deadline, published_at)
values (:'mission', :'poster', 'Aide au service', 'event', 'Servir les invités', 'Abomey-Calavi', 6.45, 2.355,
  now() + interval '2 days', 120, 5000, 5000, 1, 1, now() + interval '1 day', now() - interval '1 hour'),
  (:'mission2', :'poster', 'Distribution de flyers', 'flyers', '', 'Abomey-Calavi', 6.45, 2.355,
  now() + interval '3 days', 60, 3000, 3000, 2, 2, now() + interval '1 day', now() - interval '2 hours'),
  (:'mission3', :'poster', 'Rangement', 'other', '', 'Ouidah', 6.3667, 2.085,
  now() + interval '2 days', 60, 2000, 2000, 1, 1, now() + interval '1 day', now() - interval '3 hours');
insert into public.mission_locations (mission_id, address, lat, lng)
values (:'mission', 'Rue 12, Tankpè', 6.449, 2.356), (:'mission2', 'Carrefour IITA', 6.449, 2.356),
  (:'mission3', 'Marché', 6.3667, 2.085);
insert into public.poster_reviews (poster_id, author_name, stars, comment, context, date)
values (:'poster', 'Mireille A.', 5, 'Consignes claires.', 'Aide lors d’un événement', now() - interval '3 days');

-- Exécutant : Explorer, détail, annonceur.
select tests.login_as(:'worker');
select ok(exists(select 1 from jsonb_array_elements(public.list_missions(20,null,null,'all',false,null,null)->'items') i
  where i->>'id' = :'mission'), 'mission visible dans Explorer');
select is(tests.ids_of(public.list_missions(20,'flyers',null,'all',false,null,null)->'items', :mine::text[]), array['m-worker-2'], 'filtre par catégorie');
select is(tests.ids_of(public.list_missions(20,null,4000,'all',false,null,null)->'items', :mine::text[]), array['m-worker-1'], 'filtre par montant minimum');
select is(tests.ids_of(public.list_missions(20,null,null,'all',true,null,null)->'items', :mine::text[]), array['m-worker-2'], 'filtre multi-places');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,null,'INVITÉS')->'items', :mine::text[]), array['m-worker-1'], 'recherche dans la description');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,null,'événement')->'items', :mine::text[]), array['m-worker-1'], 'recherche dans le libellé de catégorie');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,null,null)->'items', :mine::text[]), array['m-worker-1','m-worker-2'], 'tri par publication décroissante');
select is(tests.ids_of(public.list_missions(20,null,null,'today',false,null,null)->'items', :mine::text[]), '{}'::text[], 'filtre aujourd’hui');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,'Cotonou',null)->'items', :mine::text[]), '{}'::text[], 'filtre par ville');
select ok(not exists(select 1 from jsonb_array_elements(public.list_missions(20,null,null,'all',false,null,null)->'items') i
  where i->>'id' = :'mission3'), 'mission hors rayon exclue');
select is(tests.ids_of(public.list_missions(20,null,null,'all',false,'Ouidah',null)->'items', :mine::text[]), array['m-worker-far'],
  'ville choisie : rayon ignoré');
select is(tests.city_count(public.list_cities(), 'Abomey-Calavi'), :base_cala + 2, 'villes : nombre de missions');
select is((select i->>'lat' from jsonb_array_elements(public.list_cities()->'items') i where i->>'city' = 'Ouidah'),
  '6.3667', 'villes : centre lu dans la table des villes');
select ok(not (public.get_mission(:'mission') ? 'address'), 'jamais d’adresse avant confirmation');
select is((public.get_mission(:'mission')->'pay'->>'amount')::int, 5000, 'montant par place');
select throws_ok($$ select public.get_mission('inexistant') $$, 'MO404', 'Mission introuvable.', 'mission inconnue');
select is(jsonb_array_length(public.get_poster(:'poster')->'reviews'), 1, 'profil annonceur avec avis');
select throws_ok(format($$ select public.get_poster(%L) $$, :'worker'), 'MO404', 'Annonceur introuvable.', 'annonceur inconnu');
select throws_ok($$ select public.get_poster('pas-un-uuid') $$, 'MO404', 'Annonceur introuvable.', 'identifiant d’annonceur invalide');
select throws_ok(format($$ select public.get_assignment(%L) $$, 'inexistant'), 'MO404', 'Mission introuvable.',
  'Review focus : pas d’accès sans affectation');

-- Candidature.
select public.apply_to_mission(:'mission', 'Bonjour') ->> 'id' as app \gset
select is((public.get_mission(:'mission')->>'alreadyApplied')::boolean, true, 'déjà postulé');
select throws_ok(format($$ select public.apply_to_mission(%L, 'Encore') $$, :'mission'), 'MO409',
  'Vous avez déjà postulé à cette mission.', 'double candidature refusée');

select tests.login_as(:'worker2');
select throws_ok(format($$ select public.apply_to_mission(%L, %L) $$, :'mission', repeat('a', 301)), 'MO422',
  'Votre message dépasse 300 caractères.', 'message trop long refusé');
select public.apply_to_mission(:'mission', '') ->> 'id' as app2 \gset

-- L’annonceur retient l’exécutant (insert direct de l’offre).
reset role;
update public.applications set status = 'offered', offer_expires_at = now() + interval '12 hours' where id = :'app';
select tests.login_as(:'worker');
select public.confirm_offer(:'app') ->> 'assignmentId' as assignment \gset
select is((select a->>'status' from jsonb_array_elements(public.list_my_applications()) a where a->>'id' = :'app'),
  'confirmed', 'offre confirmée');
reset role;
select is((select status from public.applications where id = :'app2'), 'rejected', 'autres candidatures closes quand la mission est complète');
select is((select slots_free from public.missions where id = :'mission'), 0, 'place décrémentée');
select is((select pay_amount from public.assignments where id = :'assignment'), 5000, 'affectation au montant par place');
select tests.login_as(:'worker');
select ok(not exists(select 1 from jsonb_array_elements(public.list_missions(20,null,null,'all',false,null,null)->'items') i
  where i->>'id' = :'mission'), 'mission complète absente d’Explorer');

-- Affectation.
select is((public.get_assignment(:'assignment')->>'address'), 'Rue 12, Tankpè', 'adresse révélée après confirmation');
select is((public.get_assignment(:'assignment')->>'travelMinutes')::int, 1, 'temps de trajet');
select throws_ok(format($$ select public.check_in(%L, 6.459, 2.356) $$, :'assignment'), 'MO422', null, 'check-in trop loin refusé');
select is((public.check_in(:'assignment', 6.4492, 2.356)->>'status'), 'in_progress', 'check-in à moins de 200 m');
select throws_ok(format($$ select public.withdraw_assignment(%L) $$, :'assignment'), 'MO409',
  'Impossible de se désister après le check-in.', 'désistement après check-in refusé');
select is((public.check_out(:'assignment', 'RAS', '[]'::jsonb)->>'status'), 'submitted', 'fin signalée');
select ok((public.get_assignment(:'assignment')->>'autoValidateAt')::timestamptz
  between now() + interval '47 hours' and now() + interval '49 hours', 'échéance à 48 h');
select ok((public.get_earnings()->'lines') @> jsonb_build_array(jsonb_build_object('status','awaiting_validation')),
  'gain en attente de validation');
select is((public.get_earnings()->'upcoming'->>'amount')::int, 5000, 'gains à venir');
select throws_ok($$ select public.get_payout('po-x') $$, 'MO404', 'Reçu introuvable.', 'reçu inconnu');

-- Désistement avant check-in.
select public.apply_to_mission(:'mission2', '') ->> 'id' as app3 \gset
reset role;
update public.applications set status = 'offered', offer_expires_at = now() + interval '12 hours' where id = :'app3';
select tests.login_as(:'worker');
select public.confirm_offer(:'app3') ->> 'assignmentId' as assignment2 \gset
select throws_ok(format($$ select public.check_out(%L, '', '[]'::jsonb) $$, :'assignment2'), 'MO409',
  'Faites d’abord votre check-in.', 'fin avant check-in refusée');
select is((public.withdraw_assignment(:'assignment2')->>'cancelledBy'), 'worker', 'désistement par l’exécutant');
reset role;
select is((select slots_free from public.missions where id = :'mission2'), 2, 'place libérée');
select tests.login_as(:'worker');
select is((public.apply_to_mission(:'mission2', 'Encore')->>'status'), 'pending', 'nouvelle candidature après désistement');
select is((public.withdraw_application(:'app3')->>'status'), 'withdrawn', 'candidature retirée');

-- Accès des autres.
select tests.login_as(:'worker2');
select public.apply_to_mission(:'mission2', '') ->> 'id' as app4 \gset
select public.apply_to_mission(:'mission3', '') ->> 'id' as app5 \gset
reset role;
update public.applications set status = 'offered', offer_expires_at = now() + interval '12 hours' where id = :'app4';
update public.applications set status = 'offered', offer_expires_at = now() - interval '1 minute' where id = :'app5';
select tests.login_as(:'worker2');
select is((public.decline_offer(:'app4')->>'status'), 'declined', 'offre déclinée');
select throws_ok(format($$ select public.confirm_offer(%L) $$, :'app5'), 'MO409',
  'Cette offre n’est plus disponible.', 'offre échue refusée');
select throws_ok(format($$ select public.get_assignment(%L) $$, :'assignment'), 'MO404', 'Mission introuvable.',
  'affectation d’un autre exécutant invisible');
select throws_ok(format($$ select public.apply_to_mission(%L, '') $$, :'mission'), 'MO409',
  'Cette mission est complète.', 'mission complète refusée');
select tests.login_as(:'nokyc');
select throws_ok(format($$ select public.apply_to_mission(%L, '') $$, :'mission2'), 'MO422',
  'Envoyez votre pièce d’identité avant de postuler.', 'candidature sans KYC refusée');
select tests.login_as(:'poster');
select is(tests.ids_of(public.list_missions(500,null,null,'all',false,null,null)->'items', :mine::text[]), '{}'::text[], 'ses propres missions exclues d’Explorer');
select is(array[tests.city_count(public.list_cities(), 'Abomey-Calavi'), tests.city_count(public.list_cities(), 'Ouidah')],
  array[:base_cala, :base_ouidah], 'ses propres missions exclues des villes');
select throws_ok(format($$ select public.apply_to_mission(%L, '') $$, :'mission2'), 'MO422',
  'Vous ne pouvez pas postuler à votre propre mission.', 'candidature à sa propre mission refusée');

-- Aides internes non appelables.
select throws_ok($$ select public.distance_km(0, 0, 1, 1) $$, '42501', null, 'distance_km non appelable');
select throws_ok($$ select public.public_mission_json(null::public.missions, null) $$, '42501', null,
  'public_mission_json non appelable');
select throws_ok($$ select public.assignment_json(null::public.assignments, null) $$, '42501', null,
  'assignment_json non appelable');

select * from finish();
rollback;
