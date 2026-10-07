begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(135);

-- Instant ISO 8601 UTC relatif à now(), comme toIso8601String().
create or replace function tests.at(delta interval) returns text language sql stable as $$
  select to_char((now() + delta) at time zone 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"')
$$;
grant execute on function tests.at(interval) to authenticated;

-- Brouillon de mission, comme draft() dans poster_api_test.dart.
create or replace function tests.draft(pay integer default 5000, slots integer default 2,
  unit text default 'flat', duration integer default 180) returns jsonb language sql as $$
  select jsonb_build_object(
    'title', 'Aide déménagement',
    'category', 'other',
    'description', 'Porter des cartons.',
    'city', 'Abomey-Calavi',
    'address', 'Rue 12, Tankpè',
    'landmark', 'Portail vert',
    'lat', 6.4490,
    'lng', 2.3560,
    'startAt', tests.at(interval '2 days'),
    'durationMin', duration,
    'payAmount', pay,
    'payUnit', unit,
    'slots', slots,
    'applyDeadline', tests.at(interval '1 day'))
$$;
grant execute on function tests.draft(integer, integer, text, integer) to authenticated;

-- Solde du portefeuille, lu en tant que postgres.
create or replace function tests.balance(poster uuid) returns integer language sql as $$
  select balance from public.wallets where poster_id = poster
$$;

select tests.make_user('p-poster@test.bj') as poster \gset
select tests.make_user('p-poster2@test.bj') as poster2 \gset
select tests.make_user('p-expert@test.bj') as expert \gset
select tests.make_user('p-fresh@test.bj') as fresh \gset
select tests.make_user('p-third@test.bj') as third \gset
select tests.make_user('p-nobody@test.bj') as nobody \gset

update public.profiles set first_name = 'Adjovi', last_name = 'H.' where id = :'poster';
update public.profiles set first_name = 'Koffi', last_name = 'D.' where id = :'poster2';
update public.profiles set first_name = 'Sènami', last_name = 'O.', kyc_status = 'verified',
  payout_account = '{"operator":"Moov Money","maskedNumber":"01 66 •• •• 12","holderName":"Sènami O."}',
  worker_profile = jsonb_build_object(
    'rating', 4.9, 'reviewsCount', 22, 'missionsCount', 31, 'reliability', 98, 'absences', 0,
    'skills', jsonb_build_array('Saisie', 'Événements'), 'pitch', 'Expérience en saisie et accueil.',
    'memberSince', '2025-08-12T10:00:00.000Z', 'verified', true,
    'doneMissions', jsonb_build_array(jsonb_build_object('category', 'data_entry', 'count', 12),
                                      jsonb_build_object('category', 'event', 'count', 9)),
    'lastReview', jsonb_build_object('author', 'Cabinet Hounkpè', 'stars', 5, 'text', 'Saisie rapide.'))
  where id = :'expert';
update public.profiles set first_name = 'Ganiou', last_name = 'A.', kyc_status = 'pending' where id = :'fresh';
update public.profiles set first_name = 'Rodrigue', last_name = 'K.', kyc_status = 'pending' where id = :'third';

select public.iso(created_at) as fresh_created from public.profiles where id = :'fresh' \gset

select tests.login_as(:'poster');
select public.set_role('poster');
select tests.login_as(:'poster2');
select public.set_role('poster');

-- ---------------------------------------------------------------------------
-- Montants
-- ---------------------------------------------------------------------------
reset role;
select is(public.format_fcfa(300000), '300' || U&'\202F' || '000' || U&'\00A0' || 'FCFA', 'format_fcfa : milliers');
select is(public.format_fcfa(1234567), '1' || U&'\202F' || '234' || U&'\202F' || '567' || U&'\00A0' || 'FCFA',
  'format_fcfa : millions');
select is(public.format_fcfa(999), '999' || U&'\00A0' || 'FCFA', 'format_fcfa : sans séparateur');
select is(public.format_fcfa(0), '0' || U&'\00A0' || 'FCFA', 'format_fcfa : zéro');
select is(public.format_fcfa(-5000), '-5' || U&'\202F' || '000' || U&'\00A0' || 'FCFA', 'format_fcfa : négatif');

-- ---------------------------------------------------------------------------
-- Publication
-- ---------------------------------------------------------------------------
select tests.login_as(:'poster');
select (public.get_wallet()->>'available')::int as available0 \gset
select public.publish_mission(tests.draft()) as m1json \gset
select (:'m1json'::jsonb)->>'id' as m1 \gset
select is((:'m1json'::jsonb)->>'status', 'published', 'publier : statut publié');
select is(((:'m1json'::jsonb)->>'blockedAmount')::int, 10000, 'publier bloque paie × places');
select is((public.get_wallet()->>'available')::int, :available0 - 10000, 'disponible réduit du montant bloqué');
select is((public.get_wallet()->>'balance')::int, 200000, 'solde inchangé à la publication');
select is(public.list_my_missions()->0->>'id', :'m1', 'la mission apparaît dans Mes missions');
select is(public.get_my_mission(:'m1')->>'payUnit', 'flat', 'détail : unité de paie');
select is(public.get_wallet()->'blocked'->0, jsonb_build_object('missionId', :'m1', 'title', 'Aide déménagement',
  'amount', 10000), 'portefeuille : ligne bloquée');
reset role;
select is((select address from public.mission_locations where mission_id = :'m1'), 'Rue 12, Tankpè',
  'adresse exacte enregistrée à part');
select is((select zone_lat from public.missions where id = :'m1'), 6.45::double precision, 'zone arrondie');
select tests.login_as(:'poster');

select throws_ok($$ select public.publish_mission(tests.draft(150000, 2)) $$, 'MO422',
  'Solde insuffisant pour bloquer 300' || U&'\202F' || '000' || U&'\00A0' || 'FCFA.', 'solde insuffisant');
select throws_ok($$ select public.publish_mission(tests.draft(5000, 2, 'hourly', 0)) $$, 'MO422',
  'Indiquez la durée.', 'mission à l’heure sans durée');
select throws_ok($$ select public.publish_mission(tests.draft() || '{"title":"  "}') $$, 'MO422',
  'Indiquez un titre.', 'titre obligatoire');
select throws_ok($$ select public.publish_mission(tests.draft(5000, 0)) $$, 'MO422',
  'Le nombre de places va de 1 à 50.', 'au moins une place');
select throws_ok($$ select public.publish_mission(tests.draft(5000, 51)) $$, 'MO422',
  'Le nombre de places va de 1 à 50.', 'au plus 50 places');
select throws_ok($$ select public.publish_mission(tests.draft(0)) $$, 'MO422',
  'Indiquez la rémunération.', 'rémunération obligatoire');
select throws_ok($$ select public.publish_mission(tests.draft() || jsonb_build_object('startAt', tests.at(interval '-1 hour'))) $$,
  'MO422', 'La date de début doit être à venir.', 'début dans le passé');
select throws_ok($$ select public.publish_mission(tests.draft() || '{"startAt":"infinity"}') $$,
  'MO422', 'La date de début doit être à venir.', 'date de début illisible');
select throws_ok($$ select public.publish_mission(tests.draft() || jsonb_build_object('applyDeadline', tests.at(interval '-1 hour'))) $$,
  'MO422', 'La date limite de candidature doit être avant le début et dans le futur.', 'date limite passée');
select throws_ok($$ select public.publish_mission(tests.draft() || jsonb_build_object('applyDeadline', tests.at(interval '3 days'))) $$,
  'MO422', 'La date limite de candidature doit être avant le début et dans le futur.', 'date limite après le début');
select tests.login_as(:'nobody');
select throws_ok($$ select public.publish_mission(tests.draft()) $$, 'MO403',
  'Passez en mode annonceur pour publier.', 'publier sans être annonceur');

-- ---------------------------------------------------------------------------
-- Candidats
-- ---------------------------------------------------------------------------
select tests.login_as(:'expert');
select public.apply_to_mission(:'m1', 'Dispo') ->> 'id' as app_expert \gset
select tests.login_as(:'fresh');
select public.apply_to_mission(:'m1', 'Je débute, très motivé.') ->> 'id' as app_fresh \gset
select tests.login_as(:'third');
select public.apply_to_mission(:'m1', '') ->> 'id' as app_third \gset
reset role;
-- Dates distinctes (now() est figé dans la transaction de test).
update public.applications set created_at = now() - interval '3 minutes' where id = :'app_expert';
update public.applications set created_at = now() - interval '2 minutes' where id = :'app_fresh';
update public.applications set created_at = now() - interval '1 minute' where id = :'app_third';

select tests.login_as(:'poster');
select is(jsonb_array_length(public.list_candidates(:'m1')), 3, 'trois candidats');
select is(public.list_candidates(:'m1')->0->>'id', :'app_expert', 'candidats par date de candidature');
select is((public.get_my_mission(:'m1')->>'newApplicantsCount')::int, 3, 'nouveaux candidats');
select public.list_candidates(:'m1')->0 as c_expert \gset
select is((:'c_expert'::jsonb)->>'name', 'Sènami O.', 'candidat : nom');
select is(((:'c_expert'::jsonb)->>'isExpert')::boolean, true, 'C10 : expert');
select is((:'c_expert'::jsonb)->'doneMissions', '[{"category":"data_entry","count":12},{"category":"event","count":9}]'::jsonb,
  'C10 : missions réalisées du profil');
select is((:'c_expert'::jsonb)->'review'->>'author', 'Cabinet Hounkpè', 'C10 : dernier avis');
select is((:'c_expert'::jsonb)->>'pitch', 'Expérience en saisie et accueil.', 'pitch du profil');
select is((:'c_expert'::jsonb)->>'status', 'pending', 'candidat en attente');
select is((:'c_expert'::jsonb)->>'attendance', 'notArrived', 'pas encore arrivé');
select is((:'c_expert'::jsonb)->>'memberSince', '2025-08-12T10:00:00.000Z', 'membre depuis (profil)');

select public.list_candidates(:'m1')->1 as c_fresh \gset
select is((:'c_fresh'::jsonb)->>'memberSince', :'fresh_created',
  'sans profil : membre depuis la création du compte');
select is((:'c_fresh'::jsonb)->>'pitch', 'Je débute, très motivé.', 'sans profil : pitch = message');
select is((:'c_fresh'::jsonb)->'rating', 'null'::jsonb, 'sans profil : pas de note');
select is(((:'c_fresh'::jsonb)->>'missionsCount')::int, 0, 'sans profil : 0 mission');
select is(((:'c_fresh'::jsonb)->>'reviewsCount')::int, 0, 'sans profil : 0 avis');
select is((:'c_fresh'::jsonb)->'skills', '[]'::jsonb, 'sans profil : aucune compétence');
select is(((:'c_fresh'::jsonb)->>'verified')::boolean, false, 'sans profil : non vérifié');
select is(((:'c_fresh'::jsonb)->>'isExpert')::boolean, false, 'sans profil : pas expert');
select is((:'c_fresh'::jsonb)->'doneMissions', '[]'::jsonb, 'sans profil : aucune mission réalisée');
select is((:'c_fresh'::jsonb)->'review', 'null'::jsonb, 'sans profil : pas d’avis');
select is(((:'c_fresh'::jsonb)->>'absences')::int, 0, 'sans profil : 0 absence');

-- Retenir : plafond offres + affectations actives ≤ places.
select is(public.offer_application(:'app_expert')->>'status', 'retained', 'candidat retenu');
select is((public.get_my_mission(:'m1')->>'status'), 'selected', 'mission : sélection en cours');
select is(public.offer_application(:'app_fresh')->>'status', 'retained', 'second candidat retenu');
select throws_ok(format($$ select public.offer_application(%L) $$, :'app_third'), 'MO409',
  'Plus de place libre sur cette mission.', 'Review focus : retenir au-delà des places');
select throws_ok(format($$ select public.offer_application(%L) $$, :'app_expert'), 'MO409',
  'Cette candidature n’est plus en attente.', 'retenir deux fois');
reset role;
select is((select status from public.applications where id = :'app_third'), 'pending', 'candidature restée en attente');

-- Offre expirée : réglée par settle_due.
update public.applications set offer_expires_at = now() - interval '1 minute' where id = :'app_fresh';
select public.settle_due();
select is((select status from public.applications where id = :'app_fresh'), 'expired', 'offre expirée après échéance');
select tests.login_as(:'poster');
select is((select c->>'status' from jsonb_array_elements(public.list_candidates(:'m1')) c where c->>'id' = :'app_fresh'),
  'refused', 'offre expirée : candidat refusé');

-- Refuser.
select is(public.reject_application(:'app_third')->>'status', 'refused', 'candidat refusé');
select throws_ok(format($$ select public.reject_application(%L) $$, :'app_third'), 'MO409',
  'Cette candidature n’est plus en attente.', 'refuser deux fois');

-- Un autre annonceur ne voit ni ne touche les candidats.
select tests.login_as(:'poster2');
select throws_ok(format($$ select public.list_candidates(%L) $$, :'m1'), 'MO404', 'Mission introuvable.',
  'candidats d’un autre annonceur');
select throws_ok(format($$ select public.offer_application(%L) $$, :'app_third'), 'MO404', 'Mission introuvable.',
  'Review focus : retenir le candidat d’un autre annonceur');
select throws_ok(format($$ select public.reject_application(%L) $$, :'app_third'), 'MO404', 'Mission introuvable.',
  'Review focus : refuser le candidat d’un autre annonceur');
select throws_ok(format($$ select public.get_my_mission(%L) $$, :'m1'), 'MO404', 'Mission introuvable.',
  'mission d’un autre annonceur');
select throws_ok(format($$ select public.cancel_mission(%L) $$, :'m1'), 'MO404', 'Mission introuvable.',
  'annuler la mission d’un autre annonceur');

-- ---------------------------------------------------------------------------
-- Mission à l’heure : cycle complet et versement
-- ---------------------------------------------------------------------------
select tests.login_as(:'poster');
select public.publish_mission(tests.draft(1000, 1, 'hourly')) as m2json \gset
select (:'m2json'::jsonb)->>'id' as m2 \gset
select is(((:'m2json'::jsonb)->>'blockedAmount')::int, 3000, 'à l’heure : bloqué = taux × durée');
select is(((:'m2json'::jsonb)->>'payAmount')::int, 1000, 'à l’heure : taux affiché à l’annonceur');
select tests.login_as(:'third');
select public.apply_to_mission(:'m2', '') ->> 'id' as app_m2 \gset
select tests.login_as(:'fresh');
select public.apply_to_mission(:'m2', '') ->> 'id' as app_m2_other \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m2');
select tests.login_as(:'third');
select public.confirm_offer(:'app_m2') ->> 'assignmentId' as as_m2 \gset
reset role;
select is((select status from public.applications where id = :'app_m2_other'), 'rejected',
  'mission complète : autres candidatures refusées');
select tests.login_as(:'third');
select public.check_in(:'as_m2', 6.4491, 2.3560);
select public.check_out(:'as_m2', 'Fait', '[]'::jsonb);
select tests.login_as(:'poster');
select is((public.get_my_mission(:'m2')->>'status'), 'inProgress', 'mission en cours');
select is((select c->>'attendance' from jsonb_array_elements(public.list_candidates(:'m2')) c where c->>'id' = :'app_m2'),
  'finished', 'fin signalée');
reset role;
select tests.balance(:'poster') as bal_m2 \gset
select tests.login_as(:'poster');
select is(public.validate_assignment(:'as_m2')->>'attendance', 'validated', 'valider : versé');
reset role;
select is(tests.balance(:'poster'), :bal_m2 - 3000, 'à l’heure : versé = taux × durée');
select ok(not exists (select 1 from public.blocked_funds where mission_id = :'m2'), 'ligne bloquée supprimée à zéro');
select is((select amount from public.payouts where assignment_id = :'as_m2'), 3000, 'reçu au montant versé');
select ok((select reference from public.payouts where assignment_id = :'as_m2')
  ~ ('^MO-' || extract(year from now() at time zone 'UTC') || '-\d{6}$'), 'référence MO-AAAA-NNNNNN');
select is((select account_label from public.payouts where assignment_id = :'as_m2'), 'MTN MoMo · •• ••',
  'compte de versement');
select is((select poster_name from public.payouts where assignment_id = :'as_m2'), 'Adjovi H.', 'nom de l’annonceur');
select tests.login_as(:'poster');
select isnt((public.get_my_mission(:'m2')->>'status'), 'completed', 'payée avant le début : pas encore terminée');
reset role;
update public.missions set start_at = now() - interval '1 minute' where id = :'m2';
select tests.login_as(:'poster');
select is((public.get_my_mission(:'m2')->>'status'), 'completed', 'mission terminée');
select is((public.get_wallet()->'payouts'->0->>'workerName'), 'Rodrigue K.', 'portefeuille : versement listé');
select throws_ok(format($$ select public.validate_assignment(%L) $$, :'as_m2'), 'MO409', 'Rien à valider.',
  'valider deux fois');
reset role;
select public.pay_assignment(:'as_m2');
select is((select count(*)::int from public.payouts where assignment_id = :'as_m2'), 1, 'pay_assignment idempotent');
select tests.login_as(:'third');
select is((select l->>'status' from jsonb_array_elements(public.get_earnings()->'lines') l
  where l->>'title' = 'Aide déménagement'), 'paid', 'gain versé côté exécutant');

-- Une affectation payée compte dans sa catégorie.
select tests.login_as(:'poster');
select public.publish_mission(tests.draft(4000, 1)) ->> 'id' as m3 \gset
select tests.login_as(:'expert');
select public.apply_to_mission(:'m3', '') ->> 'id' as app_m3 \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m3');
select tests.login_as(:'expert');
select public.confirm_offer(:'app_m3') ->> 'assignmentId' as as_m3 \gset
select public.check_in(:'as_m3', 6.4491, 2.3560);
select public.check_out(:'as_m3', 'Fait', '[]'::jsonb);

-- ---------------------------------------------------------------------------
-- Review focus 3 : versement automatique, une seule fois
-- ---------------------------------------------------------------------------
reset role;
select tests.balance(:'poster') as bal_m3 \gset
update public.assignments set auto_validate_at = now() - interval '1 minute' where id = :'as_m3';
select public.settle_due();
select public.settle_due();
select tests.login_as(:'poster');
select throws_ok(format($$ select public.validate_assignment(%L) $$, :'as_m3'), 'MO409', 'Rien à valider.',
  'Review focus : déjà versée automatiquement');
reset role;
select is((select count(*)::int from public.payouts where assignment_id = :'as_m3'), 1, 'Review focus : un seul reçu');
select is(tests.balance(:'poster'), :bal_m3 - 4000, 'Review focus : solde débité une seule fois');
select ok(not exists (select 1 from public.blocked_funds where mission_id = :'m3'), 'montant bloqué soldé');
select tests.login_as(:'poster');
select is((select c->'doneMissions' from jsonb_array_elements(public.list_candidates(:'m3')) c),
  '[{"category":"data_entry","count":12},{"category":"event","count":9},{"category":"other","count":1}]'::jsonb,
  'C10 : affectation payée comptée dans sa catégorie');

-- Versement automatique déclenché par une lecture (get_wallet), comme le faux serveur.
select public.publish_mission(tests.draft(2000, 1)) ->> 'id' as m4 \gset
select tests.login_as(:'fresh');
select public.apply_to_mission(:'m4', '') ->> 'id' as app_m4 \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m4');
select tests.login_as(:'fresh');
select public.confirm_offer(:'app_m4') ->> 'assignmentId' as as_m4 \gset
select public.check_in(:'as_m4', 6.4491, 2.3560);
select public.check_out(:'as_m4', 'Fait', '[]'::jsonb);
reset role;
select tests.balance(:'poster') as bal_m4 \gset
update public.assignments set auto_validate_at = now() - interval '1 minute' where id = :'as_m4';
select tests.login_as(:'poster');
select is((public.get_wallet()->>'balance')::int, :bal_m4 - 2000, 'versement automatique à la lecture du portefeuille');

-- ---------------------------------------------------------------------------
-- Contestation
-- ---------------------------------------------------------------------------
select public.publish_mission(tests.draft(2500, 1)) ->> 'id' as m5 \gset
select tests.login_as(:'third');
select public.apply_to_mission(:'m5', '') ->> 'id' as app_m5 \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m5');
select tests.login_as(:'third');
select public.confirm_offer(:'app_m5') ->> 'assignmentId' as as_m5 \gset
select public.check_in(:'as_m5', 6.4491, 2.3560);
select public.check_out(:'as_m5', 'Fait', '[]'::jsonb);

-- Un autre compte ne peut ni valider ni contester.
select throws_ok(format($$ select public.validate_assignment(%L) $$, :'as_m5'), 'MO404', 'Mission introuvable.',
  'Review focus : l’exécutant ne peut pas valider');
select throws_ok(format($$ select public.contest_assignment(%L, 'x') $$, :'as_m5'), 'MO404', 'Mission introuvable.',
  'Review focus : l’exécutant ne peut pas contester');
select tests.login_as(:'poster2');
select throws_ok(format($$ select public.validate_assignment(%L) $$, :'as_m5'), 'MO404', 'Mission introuvable.',
  'un autre annonceur ne peut pas valider');
select throws_ok(format($$ select public.contest_assignment(%L, 'x') $$, :'as_m5'), 'MO404', 'Mission introuvable.',
  'un autre annonceur ne peut pas contester');

select tests.login_as(:'poster');
select throws_ok(format($$ select public.contest_assignment(%L, '   ') $$, :'as_m5'), 'MO422', 'Indiquez le motif.',
  'motif obligatoire');
reset role;
select tests.balance(:'poster') as bal_m5 \gset
select tests.login_as(:'poster');
select is(public.contest_assignment(:'as_m5', ' Travail incomplet ')->>'attendance', 'contested', 'contestation');
reset role;
select is((select contest_reason from public.assignments where id = :'as_m5'), 'Travail incomplet', 'motif enregistré');
update public.assignments set auto_validate_at = now() - interval '1 minute' where id = :'as_m5';
select public.settle_due();
select is(tests.balance(:'poster'), :bal_m5, 'contestation : rien n’est versé après l’échéance');
select is((select count(*)::int from public.payouts where assignment_id = :'as_m5'), 0, 'contestation : aucun reçu');
select tests.login_as(:'poster');
select throws_ok(format($$ select public.validate_assignment(%L) $$, :'as_m5'), 'MO409', 'Rien à valider.',
  'valider une affectation contestée');
select throws_ok(format($$ select public.cancel_mission(%L) $$, :'m5'), 'MO409',
  'Impossible d’annuler : la mission a commencé.', 'annulation refusée une fois la mission commencée');

-- ---------------------------------------------------------------------------
-- Annulation
-- ---------------------------------------------------------------------------
select public.publish_mission(tests.draft()) ->> 'id' as m6 \gset
select (public.get_wallet()->>'available')::int as available6 \gset
select tests.login_as(:'third');
select public.apply_to_mission(:'m6', '') ->> 'id' as app_m6 \gset
select tests.login_as(:'fresh');
select public.apply_to_mission(:'m6', '') ->> 'id' as app_m6_pending \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m6');
select tests.login_as(:'third');
select public.confirm_offer(:'app_m6') ->> 'assignmentId' as as_m6 \gset
select tests.login_as(:'poster');
select is(public.cancel_mission(:'m6')->>'status', 'cancelled', 'mission annulée');
select is((public.get_wallet()->>'available')::int, :available6 + 10000, 'annulation : montant débloqué');
select throws_ok(format($$ select public.cancel_mission(%L) $$, :'m6'), 'MO409', 'Cette mission est déjà annulée.',
  'double annulation refusée');
select tests.login_as(:'third');
select is((select a->>'status' from jsonb_array_elements(public.list_my_applications()) a where a->>'id' = :'app_m6'),
  'cancelled', 'annulation : candidature annulée côté exécutant');
select is(public.get_assignment(:'as_m6')->>'status', 'cancelled', 'annulation : affectation annulée');
select is(public.get_assignment(:'as_m6')->>'cancelledBy', 'poster', 'annulation : par l’annonceur');
reset role;
select is((select status from public.applications where id = :'app_m6_pending'), 'rejected',
  'annulation : candidatures en attente refusées');

-- ---------------------------------------------------------------------------
-- Nouvelle candidature après désistement : même ligne, vue à jour
-- ---------------------------------------------------------------------------
select tests.login_as(:'poster');
select public.publish_mission(tests.draft(3000, 1)) ->> 'id' as m7 \gset
select tests.login_as(:'third');
select public.apply_to_mission(:'m7', '') ->> 'id' as app_m7 \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m7');
select tests.login_as(:'third');
select public.confirm_offer(:'app_m7') ->> 'assignmentId' as as_m7 \gset
select public.withdraw_assignment(:'as_m7');
select is(public.apply_to_mission(:'m7', 'De retour')->>'id', :'app_m7', 'candidature rouverte');
select tests.login_as(:'poster');
select public.list_candidates(:'m7')->0 as c_m7 \gset
select is((:'c_m7'::jsonb)->>'status', 'pending', 'rouverte : en attente');
select is((:'c_m7'::jsonb)->'assignmentId', 'null'::jsonb, 'rouverte : plus d’affectation');
select is((:'c_m7'::jsonb)->>'attendance', 'notArrived', 'rouverte : pas d’ancienne présence');
select is((public.get_my_mission(:'m7')->>'slotsConfirmed')::int, 0, 'rouverte : aucune place confirmée');
select is((public.get_my_mission(:'m7')->>'applicantsCount')::int, 1, 'rouverte : un seul candidat');
select is(public.offer_application(:'app_m7')->>'status', 'retained', 'rouverte : peut être retenue');
select tests.login_as(:'third');
select public.confirm_offer(:'app_m7') ->> 'assignmentId' as as_m7b \gset
select tests.login_as(:'poster');
select is(public.list_candidates(:'m7')->0->>'assignmentId', :'as_m7b', 'rouverte : nouvelle affectation affichée');

-- Le règlement s’applique aussi aux lectures de l’exécutant.
select public.publish_mission(tests.draft(1500, 1)) ->> 'id' as m8 \gset
select tests.login_as(:'fresh');
select public.apply_to_mission(:'m8', '') ->> 'id' as app_m8 \gset
select tests.login_as(:'poster');
select public.offer_application(:'app_m8');
reset role;
update public.applications set offer_expires_at = now() - interval '1 minute' where id = :'app_m8';
select tests.login_as(:'fresh');
select is((select a->>'status' from jsonb_array_elements(public.list_my_applications()) a where a->>'id' = :'app_m8'),
  'expired', 'offre échue réglée à la lecture par l’exécutant');

-- ---------------------------------------------------------------------------
-- Règlement isolé : une affectation impossible à verser n’empêche pas les autres appels
-- ---------------------------------------------------------------------------
reset role;
insert into public.missions (id, poster_id, title, category, city, zone_lat, zone_lng, start_at, duration_min,
  pay_amount, slot_amount, slots_total, slots_free, apply_deadline)
values ('m-broken', :'poster', 'Mission incohérente', 'other', 'Abomey-Calavi', 6.45, 2.36, now() - interval '1 day',
  60, 2000, 2000, 1, 0, now() - interval '2 days');
insert into public.applications (id, mission_id, worker_id, status, assignment_id)
values ('a-broken', 'm-broken', :'third', 'confirmed', 'as-broken');
-- Aucune ligne bloquée : le versement est impossible.
insert into public.assignments (id, mission_id, application_id, worker_id, status, pay_amount, auto_validate_at)
values ('as-broken', 'm-broken', 'a-broken', :'third', 'submitted', 2000, now() - interval '1 minute');
select tests.balance(:'poster') as bal_broken \gset
select lives_ok($$ select public.settle_due() $$, 'settle_due ignore la mission incohérente');
select is((select status from public.assignments where id = 'as-broken'), 'submitted',
  'affectation incohérente restée soumise');
select is(tests.balance(:'poster'), :bal_broken, 'aucun débit partiel');
select is((select count(*)::int from public.payouts where assignment_id = 'as-broken'), 0, 'aucun reçu partiel');
select tests.login_as(:'poster2');
select lives_ok($$ select public.get_wallet() $$, 'un autre annonceur lit toujours son portefeuille');
select tests.login_as(:'poster');
select lives_ok($$ select public.list_my_missions() $$, 'l’annonceur concerné lit toujours ses missions');
select throws_ok($$ select public.validate_assignment('as-broken') $$, 'P0001', null,
  'validation directe : l’erreur est levée');

-- ---------------------------------------------------------------------------
-- Identifiants inconnus : erreurs métier, pas d’erreur de contrainte
-- ---------------------------------------------------------------------------
select tests.login_as(:'third');
select throws_ok($$ select public.apply_to_mission('inexistant', '') $$, 'MO404',
  'Cette mission n’est plus disponible.', 'postuler à une mission inconnue');
select throws_ok($$ select public.confirm_offer('inexistant') $$, 'MO404', 'Candidature introuvable.',
  'confirmer une offre inconnue');
select throws_ok($$ select public.decline_offer('inexistant') $$, 'MO404', 'Candidature introuvable.',
  'décliner une offre inconnue');
select throws_ok($$ select public.withdraw_application('inexistant') $$, 'MO404', 'Candidature introuvable.',
  'retirer une candidature inconnue');
select throws_ok($$ select public.check_in('inexistant', 6.4491, 2.3560) $$, 'MO404', 'Mission introuvable.',
  'check-in sur une affectation inconnue');
select throws_ok($$ select public.check_out('inexistant', '', '[]'::jsonb) $$, 'MO404', 'Mission introuvable.',
  'fin sur une affectation inconnue');
select throws_ok($$ select public.withdraw_assignment('inexistant') $$, 'MO404', 'Mission introuvable.',
  'désistement d’une affectation inconnue');

-- ---------------------------------------------------------------------------
-- Droits, planification, invariants
-- ---------------------------------------------------------------------------
select throws_ok($$ select public.settle_due() $$, '42501', null, 'settle_due non appelable');
select throws_ok(format($$ select public.pay_assignment(%L) $$, :'as_m5'), '42501', null, 'pay_assignment non appelable');
select throws_ok($$ select public.format_fcfa(1) $$, '42501', null, 'format_fcfa non appelable');
select tests.as_anon();
select throws_ok($$ select public.get_wallet() $$, '42501', null, 'anon ne peut pas lire un portefeuille');
reset role;
select ok(not exists (
    select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and has_function_privilege('authenticated', p.oid, 'execute') and not p.prosecdef),
  'toute fonction accordée à authenticated est security definer');
select is((select count(*)::int from cron.job where jobname = 'settle-due' and schedule = '*/5 * * * *'
  and command = 'select public.settle_due()'), 1, 'cron.job contient settle-due');
select ok(not exists (select 1 from public.wallets where balance < 0), 'aucun solde négatif');
select throws_ok(format($$ insert into public.payouts (id, worker_id, assignment_id, amount, gross_amount, mission_title,
  poster_name, validated_at, account_label, reference) values ('po-dup', %L, %L, 1, 1, 't', 'p', now(), 'a', 'r') $$,
  :'third', :'as_m2'), '23505', null, 'un seul versement par affectation');

select * from finish();
rollback;
