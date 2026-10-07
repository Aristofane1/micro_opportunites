begin;
create schema if not exists tests;
\set with_helpers 1
\ir 00_helpers.sql
select plan(28);

select tests.make_user('awa@test.bj') as awa \gset
select tests.make_user('kofi@test.bj') as kofi \gset
select tests.login_as(:'awa');

-- me / profil / rôle
select is((public.me()->>'role'), null, 'nouveau compte sans rôle');
select is((public.me()->>'email'), 'awa@test.bj', 'e-mail du compte');
select is((public.me()->>'city'), 'Abomey-Calavi', 'ville par défaut');
select throws_ok($$ select public.save_profile(' ','Dossou','2000-01-01', true, false) $$,
  'MO422', 'Prénom et nom sont obligatoires.', 'prénom obligatoire');
select throws_ok($$ select public.save_profile('Awa','Dossou','2000-01-01', false, false) $$,
  'MO422', 'Vous devez accepter les conditions générales.', 'conditions obligatoires');
select throws_ok($$ select public.save_profile('Awa','Dossou','pas une date', true, false) $$,
  'MO422', 'Date de naissance invalide.', 'date invalide');
select throws_ok($$ select public.save_profile('Awa','Dossou', to_char(now() - interval '17 years','YYYY-MM-DD'), true, false) $$,
  'MO422', 'Vous devez avoir au moins 18 ans.', '18 ans minimum');
select is((public.save_profile('Awa','Dossou','2000-01-01', true, true)->>'firstName'), 'Awa', 'profil enregistré');
select is((public.me()->>'firstName'), 'Awa', 'prénom visible dans me()');
select throws_ok($$ select public.set_role('admin') $$, 'MO422', 'Rôle inconnu.', 'rôle inconnu refusé');
select is((public.set_role('poster')->>'role'), 'poster', 'rôle annonceur');
reset role; -- lecture en tant que postgres : le portefeuille n’est pas lisible en direct (RLS)
select is((select balance from public.wallets where poster_id = :'awa'), 200000, 'portefeuille de démo');
select is((select poster_profile->>'displayName' from public.profiles where id = :'awa'), 'Awa D.', 'profil annonceur initial');
select tests.login_as(:'awa');
select is((public.set_role('worker')->>'role'), 'worker', 'retour au rôle exécutant');
select is((public.set_role('poster')->>'role'), 'poster', 'rôle annonceur à nouveau');
reset role; -- lecture en tant que postgres : le portefeuille n’est pas lisible en direct (RLS)
select is((select balance from public.wallets where poster_id = :'awa'), 200000, 'portefeuille non recréé');
select tests.login_as(:'awa');

-- KYC
select is((public.get_kyc()->>'status'), 'none', 'KYC absent au départ');
select throws_ok(format($$ select public.submit_kyc('permis','BJ', %L, %L, %L) $$,
    :'awa' || '/c0/front.jpg', :'awa' || '/c0/back.jpg', :'awa' || '/c0/selfie.jpg'),
  'MO422', 'Type de pièce inconnu.', 'type de pièce inconnu');
select throws_ok(format($$ select public.submit_kyc('passport',' ', %L, null, %L) $$,
    :'awa' || '/c0/front.jpg', :'awa' || '/c0/selfie.jpg'),
  'MO422', 'Indiquez le pays de la pièce.', 'pays obligatoire');
select throws_ok(format($$ select public.submit_kyc('id_card','BJ', %L, null, %L) $$,
    :'awa' || '/c0/front.jpg', :'awa' || '/c0/selfie.jpg'),
  'MO422', 'Photographiez le recto et le verso.', 'verso obligatoire pour une carte');
select is((public.submit_kyc('passport','BJ', :'awa' || '/c1/front.jpg', null, :'awa' || '/c1/selfie.jpg')->>'status'), 'pending', 'KYC en attente');
select is((public.get_kyc()->>'status'), 'pending', 'KYC relu en attente');

-- Alertes
select throws_ok($$ select public.create_alert(null, null, '  ', null, 'Lun') $$,
  'MO422', 'Choisissez une zone et des jours.', 'zone obligatoire');
select public.create_alert('serveur', 'Événementiel', 'Cotonou', 5000, 'Sam, Dim') ->> 'id' as alert \gset
select is(jsonb_array_length(public.list_alerts()), 1, 'alerte listée');

select tests.login_as(:'kofi');
select is(jsonb_array_length(public.list_alerts()), 0, 'alertes d’autrui invisibles');
select throws_ok(format($$ select public.delete_alert(%L) $$, :'alert'),
  'MO404', 'Alerte introuvable.', 'suppression de l’alerte d’autrui refusée');

select tests.logout();
select throws_ok($$ select public.me() $$, 'MO401', 'Votre session a expiré. Reconnectez-vous.', 'Review focus : déconnecté');
select tests.as_anon();
select throws_ok($$ select public.me() $$, '42501', null, 'anon ne peut pas appeler les RPC');
select * from finish();
rollback;
