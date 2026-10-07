# Supabase

Backend de l’application : schéma Postgres, droits (RLS), fonctions RPC et tests pgTAP.

## Mise en place

Prérequis : Supabase CLI installée, Docker démarré (les tests tournent dans un conteneur
`pg_prove`).

1. Créer un projet sur supabase.com, activer les extensions `pg_cron` et `pgtap`, et la
   confirmation automatique des e-mails.
2. Récupérer l’URL du projet, la clé publique (anon), la clé `service_role` et la chaîne
   « session pooler ». Les écrire dans `supabase/.env` (`SUPABASE_DB_URL`, `SUPABASE_URL`,
   `SUPABASE_SERVICE_ROLE_KEY`) ; l’URL et la clé anon vont aussi dans `env/dev.json`
   (`SUPABASE_URL`, `SUPABASE_ANON_KEY`, sur le modèle de `env/example.json`).
3. Appliquer les migrations (voir plus bas), puis semer les données de démo.
4. Lancer l’app : `flutter run --dart-define-from-file=env/dev.json`.

Charger les variables dans la commande qui en a besoin, et ne jamais afficher la chaîne de
connexion (filtrer la sortie avec `| grep -viE "postgres(ql)?://"`).

## Migrations

```bash
set -a; source supabase/.env; set +a
supabase db push --db-url "$SUPABASE_DB_URL" | grep -viE "postgres(ql)?://"
```

`db push` n’applique que les migrations manquantes : après une mise à jour du dépôt, le
relancer (par exemple pour `…000007`).

- `migrations/20261006000001_schema.sql` : tables, RLS, buckets privés `kyc` et `proofs`.
- `migrations/20261006000002_identity.sql` : `me`, `set_role`, `save_profile`, `submit_kyc`,
  `get_kyc`, `list_alerts`, `create_alert`, `delete_alert`.
- `migrations/20261006000003_security.sql` : droits d’exécution explicites, policies du
  bucket `proofs` via `can_upload_proof` / `can_read_proof`, validation du type et du pays
  de la pièce d’identité.
- `migrations/20261006000004_worker.sql` : côté exécutant (missions, candidatures,
  affectations, gains).
- `migrations/20261006000005_poster.sql` : côté annonceur (publication, candidats,
  validation, contestation, annulation, portefeuille), versements (`pay_assignment`) et
  échéances (`settle_due`). `settle_due` est appelée au début de chaque RPC et planifiée
  toutes les 5 minutes par pg_cron (tâche `settle-due`).
- `migrations/20261006000006_seed_fn.sql` : `seed_demo(accounts, reset)`, données de
  démonstration (réservée à `service_role`).
- `migrations/20261006000007_final_fixes.sql` : candidatures closes à la date limite ;
  plus d’offre ni de confirmation une fois la mission commencée ; clôture du recrutement au
  début de la mission par `settle_due` (places vides débloquées, mission sans affectation
  annulée) ; mission « terminée » dès que toutes ses affectations sont terminales et qu’au
  moins une est payée ; position de l’appareil (`lat`, `lng`) pour Explorer ; message
  propre au selfie manquant.

Toute écriture passe par les fonctions RPC (`security definer`). Les clients n’ont que
quelques lectures directes : leur profil, les villes et leurs alertes. Les erreurs métier
sont levées avec un code `MO<statut>` (par exemple `MO422`, `MO401`) et le message à
afficher.

### Droits d’exécution : toujours explicites

La migration `…000003` révoque par défaut le droit d’exécution des nouvelles fonctions
(`alter default privileges … revoke execute on functions from public`), et cette
révocation vaut **pour tous les schémas**, pas seulement `public`. Une fonction créée par
une migration future n’est donc exécutable par personne : chaque migration qui crée une
RPC, ou qui change sa signature (ce qui crée une nouvelle fonction), doit terminer par son
`grant execute on function public.<rpc>(<types>) to authenticated;`. Un
`create or replace` sur la même signature garde les droits.

Les aides internes (`err`, `uid`, `iso`, `*_json`…) ne reçoivent aucun droit : elles ne
sont appelées que depuis des fonctions `security definer`, qui s’exécutent en tant que
propriétaire. Une fonction utilisée dans une policy (comme `can_read_proof`) doit être
`security definer` et accordée à `authenticated`.

Le test `tests/07_final_fixes_test.sql` compare les fonctions exécutables par
`authenticated` à la liste des RPC de `lib/app/backend/supabase_routes.dart` (plus les deux
fonctions des policies) : toute nouvelle RPC doit être ajoutée aux deux endroits.

## Tests

```bash
supabase test db --db-url "$SUPABASE_DB_URL"
```

Chaque fichier de test tourne dans `begin … rollback` : rien n’est conservé, et les tests
ne dépendent pas des données déjà présentes. `tests/00_helpers.sql` est inclus par les
autres fichiers (`\ir`) ; lancé seul, il ne crée rien et apparaît comme « skipped ».

Pour tester sans toucher au projet en ligne : `supabase start` puis `supabase db reset`
(qui rejoue toutes les migrations en local) et `supabase test db`.

## Données de démo

Reprise de `test/support/fake_backend/seed.dart` (mêmes identifiants `m1`…, `a1`…, `as1`,
`po1`…, textes et montants).

```bash
npm --prefix supabase/seed install
node supabase/seed/seed.mjs          # n’écrit que ce qui manque
node supabase/seed/seed.mjs --reset  # remet les données de démo dans leur état initial
```

Le script lit `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY` dans `supabase/.env` (les
variables d’environnement sont prioritaires), crée ou retrouve les comptes par l’API admin,
puis appelle `seed_demo`. Comptes avec le mot de passe `demo123` : `executant@demo.bj`
(Rodrigue), `executant2@demo.bj` (Sènami), `annonceur@demo.bj` (Mireille). Les comptes
techniques `ganiou@demo.local` et `p1@demo.local`…`p3@demo.local` n’ont pas de mot de passe.
Le reset ne supprime que les données des 7 comptes de démo et les identifiants de démo.

Les missions semées sont datées par rapport à l’heure du seed (« demain à 10 h »,
« aujourd’hui à 15 h »…). Avec le temps, leurs dates limites passent, `settle_due` clôt
leur recrutement et Explorer se vide : relancer `node supabase/seed/seed.mjs --reset`.

## Validation KYC (manuelle)

Il n’y a pas encore d’écran d’administration. Pour valider une identité, exécuter dans le
SQL editor du projet :

```sql
update public.profiles set kyc_status = 'verified' where email = 'adresse@exemple.bj';
```

(`'rejected'` pour refuser.) Les photos sont dans le bucket `kyc`, sous le dossier de
l’utilisateur.

## Secrets

`supabase/.env` et `env/dev.json` sont ignorés par git : ne jamais les commiter, les
afficher ni les coller dans un message. La clé `service_role` reste hors de l’app : l’app
ne reçoit que `SUPABASE_URL` et `SUPABASE_ANON_KEY`.
