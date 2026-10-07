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

## Données : Supabase (RPC), faux serveur pour les tests

```
Page → Contrôleur (@riverpod) → Repository → RemoteDataSource → ApiClient
                                                                 ├─ FakeApiClient (test/support/fake_backend, tests seulement)
                                                                 └─ SupabaseApiClient (app/backend : Auth, Storage, RPC)
```

- Port `ApiClient` (`core/network`) ; adaptateur Supabase dans
  `app/backend/supabase_api_client.dart` (Auth, Storage, RPC). La logique
  métier est en SQL, dans `supabase/migrations`.
- Chaque source distante appelle des routes REST (`GET /missions`, `POST
  /applications/:id/confirm`…) et parse du JSON avec des modèles
  `json_serializable` convertis en entités (`toEntity()`).
- Le faux serveur (`test/support/fake_backend`, utilisé par les tests) répond aux mêmes routes avec des
  données de démonstration et applique les règles (candidature unique,
  check-in à moins de 200 m, gains…).
- L'app réelle fournit `apiClientProvider` via l'adaptateur Supabase
  (`app/backend`) ; les tests le remplacent par `FakeApiClient`.
  `app/bootstrap.dart` fournit `locationServiceProvider` (geolocator ; les
  tests utilisent le simulateur).
- Après une écriture réussie, les contrôleurs d'action incrémentent
  `dataRevisionProvider` : toutes les listes qui le surveillent se rechargent.

### Dette de contrat API

- Les alertes échangent des chaînes d'affichage françaises pour
  catégorie/zone/jours : une API plus stricte exigera des codes structurés
  (valeur `apiValue` de la catégorie, rayon/ville, ensemble de jours).

## Features

| Feature | Écrans | Données |
|---|---|---|
| account | salutation | Supabase (RPC) |
| missions | B01 Explorer, B02 Carte, B03 Filtres, B04 Recherche, B05 Détail, B17 Profil annonceur | Supabase (RPC) |
| applications | B06 Postuler, B07 Envoyée, B08 Mes candidatures, B09 Offre | Supabase (RPC) |
| assignments | B10 Confirmée, B11 En cours, B12 Signaler la fin, B13 Attente de validation | Supabase (RPC) |
| earnings | B14 Gains, B15 Reçu | Supabase (RPC) |
| alerts | B16 Mes alertes | Supabase (RPC) |
| onboarding | A01 Splash, A02–A04 Présentation | locales (la reprise au lancement est composée par `app/`) |
| auth | A05 E-mail, A07 Infos, A08 Pièce, A09 Photos (recto, verso, selfie), A11 Vérification | Supabase Auth (connexion, inscription, déconnexion) + RPC (profil, pièce d'identité) + Storage (photos de la pièce) |
| preferences | A13 Profil de départ, A14 Autorisations (affichage) | locales (le choix du rôle est enregistré par `app/`) |
| annonceur | C01 Mes missions, C02–C04 Publier en 3 étapes, C07 Mission publiée, C08 Gérer, C09 Candidats, C10 Profil candidat, C11 Suivi du jour, C12 Valider, C13 Contester, C14 Annuler, C15 Paiements (C05/C06 retirés) | Supabase (RPC) |
| A12 refus KYC · profile · payment · chat · reviews · notifications · safety | modules A, D, E | à venir |

### Comptes de démo

Mot de passe `demo123` : `executant@demo.bj` (Rodrigue),
`executant2@demo.bj` (Sènami), `annonceur@demo.bj` (Mireille, solde 200 000 FCFA).
Le faux serveur (tests) et les fonctions SQL appliquent les règles annonceur : argent bloqué à la
publication, adresse précise visible après confirmation, versement à la
validation, débloquage à l'annulation.
