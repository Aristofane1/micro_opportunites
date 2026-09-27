# Features

Une fonctionnalité = un dossier `lib/features/<nom>/`, découpé en trois couches.

```
features/<nom>/
├─ domain/          Dart pur : aucun import Flutter, Riverpod ni data
│  ├─ entities/     objets métier immuables (freezed)
│  ├─ repositories/ contrats : abstract interface class XRepository
│  └─ usecases/     une action métier par classe
├─ data/
│  ├─ datasources/  accès distant / local
│  ├─ models/       DTO + conversion vers les entités
│  └─ repositories/ implémentations des contrats, renvoient Result<T>
└─ presentation/
   ├─ controllers/  @riverpod (AsyncNotifier) : chargement / vide / erreur
   ├─ pages/
   └─ widgets/
```

## Règles

- Dépendances : `presentation → domain ← data`. Le domaine ne dépend de rien.
- Les repositories renvoient `Result<T>` (`core/error/result.dart`) et traduisent
  les exceptions en `Failure` typées ; l'UI affiche `failure.message`.
- Les providers des repositories et des cas d'usage sont déclarés dans
  `data/<nom>_providers.dart` (implémentation du repository) et exposés
  typés par leur contrat de domaine ; `presentation/` n'importe que ce
  fichier de providers, jamais un autre fichier de `data/`.
- L'UI n'utilise que les composants de `core/ui/widgets/` et les jetons de
  `core/theme/` : aucune couleur littérale, aucune icône Material.
- Chaque écran gère ses états chargement / vide / erreur (`LoadingView`,
  `EmptyState`, `ErrorView`).
- Une feature n'importe jamais `data/` ou `presentation/` d'une autre feature ;
  ce qui est partagé va dans `core/`.
- Nouvelle route : ajouter la constante dans `app/router/app_routes.dart`,
  puis renseigner `builder:` (et `routes:` pour ses sous-pages) sur l'onglet
  correspondant dans `app/router/shell_tabs.dart`. Un flux plein écran
  au-dessus de la barre de navigation utilise
  `parentNavigatorKey: rootNavigatorKey`.
- Après tout changement d'annotation : `dart run build_runner build`.

## Features prévues (design)

onboarding · kyc · profile · missions · publish · payment · applications ·
assignments · earnings · chat · reviews · disputes · notifications · safety
