# MicroOpportunités

Application Flutter de missions rémunérées près de chez soi, au Bénin : un exécutant
trouve une mission, postule, la réalise et est payé ; un annonceur publie une mission,
choisit ses candidats et valide le travail. Les données passent par Supabase (Auth,
Storage, fonctions RPC en SQL).

## Prérequis

Flutter 3.41.1, géré avec [fvm](https://fvm.app) :

```bash
fvm install 3.41.1
fvm use 3.41.1
fvm flutter pub get
```

(Sans fvm, utiliser directement un Flutter 3.41.1.)

## Configuration

L’app lit l’URL du projet Supabase et sa clé publique (anon) au lancement :

```bash
cp env/example.json env/dev.json
```

puis remplir `SUPABASE_URL` et `SUPABASE_ANON_KEY` dans `env/dev.json`. Ce fichier est
ignoré par git : ne jamais le commiter. La clé `service_role` n’entre jamais dans l’app.

## Lancer

```bash
fvm flutter run --dart-define-from-file=env/dev.json
```

## Tests

```bash
fvm flutter analyze
fvm flutter test
```

Les tests utilisent un faux serveur en mémoire (`test/support/fake_backend`) qui applique
les mêmes règles que les fonctions SQL.

## Documentation

- [supabase/README.md](supabase/README.md) : migrations, droits, tests pgTAP et données
  de démo.
- [lib/features/README.md](lib/features/README.md) : architecture des features, règles de
  couches et liste des écrans.
