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

## Données : aujourd'hui fictives, demain l'API

```
Page → Contrôleur (@riverpod) → Repository → RemoteDataSource → ApiClient
                                                                 ├─ FakeApiClient (lib/dev/fake_api)
                                                                 └─ client HTTP (à écrire)
```

- Chaque source distante appelle des routes REST (`GET /missions`, `POST
  /applications/:id/confirm`…) et parse du JSON avec des modèles
  `json_serializable` convertis en entités (`toEntity()`).
- Le faux serveur (`lib/dev/fake_api`) répond aux mêmes routes avec des
  données de démonstration et applique les règles (candidature unique,
  check-in à moins de 200 m, gains…).
- Brancher l'API : écrire un `HttpApiClient implements ApiClient`, puis le
  fournir dans `app/bootstrap.dart` à la place de `FakeApiClient`. Rien d'autre
  ne change. `app/bootstrap.dart` fournit aussi `locationServiceProvider`
  (position simulée aujourd'hui, geolocator demain).
- Après une écriture réussie, les contrôleurs d'action incrémentent
  `dataRevisionProvider` : toutes les listes qui le surveillent se rechargent.

### Dette de contrat API

1. Les photos de check-out sont envoyées comme chemins locaux : la vraie API
   aura besoin d'une méthode d'upload sur `ApiClient` (ou d'un port média).
2. Les alertes échangent des chaînes d'affichage françaises pour
   catégorie/zone/jours : la vraie API exigera des codes structurés (valeur
   `apiValue` de la catégorie, rayon/ville, ensemble de jours).

## Features

| Feature | Écrans | Statut |
|---|---|---|
| account | salutation | fait (données fictives) |
| missions | B01 Explorer, B02 Carte, B03 Filtres, B04 Recherche, B05 Détail, B17 Profil annonceur | fait |
| applications | B06 Postuler, B07 Envoyée, B08 Mes candidatures, B09 Offre | fait |
| assignments | B10 Confirmée, B11 En cours, B12 Signaler la fin, B13 Attente de validation | fait |
| earnings | B14 Gains, B15 Reçu | fait |
| alerts | B16 Mes alertes | fait |
| onboarding | A01 Splash, A02–A04 Présentation | fait (fusion branche onboarding) |
| auth | A05 Téléphone, A06 Code SMS, A07 Infos, A08 Pièce, A09 Photo (simulée), A11 Vérification | fait (faux serveur) |
| preferences | A13 Profil de départ, A14 Autorisations (affichage) | fait |
| annonceur | C01 Mes missions, C02–C04 Publier en 3 étapes, C07 Mission publiée, C08 Gérer, C09 Candidats, C10 Profil candidat, C11 Suivi du jour, C12 Valider, C13 Contester, C14 Annuler, C15 Paiements (C05/C06 retirés) | fait (faux serveur) |
| A10 selfie · A12 refus KYC · profile · payment · chat · reviews · notifications · safety | modules A, D, E | à venir |

### Comptes de démo

Mot de passe `demo123` : `executant@demo.bj` (Rodrigue),
`executant2@demo.bj` (Sènami), `annonceur@demo.bj` (Mireille, solde 200 000 FCFA).
Le faux serveur applique les règles annonceur : argent bloqué à la
publication, adresse précise visible après confirmation, versement à la
validation, débloquage à l'annulation.
