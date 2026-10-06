import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/mes_missions/gerer_mission_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/publier/confirmer_telephone_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/publier/mission_publiee_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/publier/publier_shell_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/mes_missions/mes_missions_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/candidats/candidats_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/candidats/profil_candidat_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/mes_missions/suivi_du_jour_screen.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/validation/valider_travail_screen.dart';

/// Écrans plein écran de l'Annonceur (par-dessus la barre du bas).
final posterFullScreenRoutes = <RouteBase>[
  GoRoute(
    path: AppRoutes.posterPublishNew,
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const PublierShellScreen(),
  ),
  GoRoute(
    path: AppRoutes.posterPublishConfirm,
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const ConfirmerTelephoneScreen(),
  ),
  GoRoute(
    path: AppRoutes.posterPublishDone,
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) => const MissionPublieeScreen(),
  ),
];

/// Sous-routes de l'onglet « Mes missions » : la barre du bas reste visible
/// (comme sur la maquette « Gérer la mission »).
final posterMissionsTabRoutes = <RouteBase>[
  GoRoute(
    path: 'manage/:id',
    builder: (context, state) =>
        GererMissionScreen(missionId: state.pathParameters['id']!),
    routes: [
      // Dans l'onglet : la barre du bas reste visible (comme la maquette)
      GoRoute(
        path: 'candidates',
        builder: (context, state) =>
            CandidatsScreen(missionId: state.pathParameters['id']!),
      ),
      // Plein écran, par-dessus la barre du bas
      GoRoute(
        path: 'candidate/:candidateId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProfilCandidatScreen(
          missionId: state.pathParameters['id']!,
          candidateId: state.pathParameters['candidateId']!,
        ),
      ),
      GoRoute(
        path: 'today',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            SuiviDuJourScreen(missionId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: 'validate/:candidateId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ValiderTravailScreen(
          missionId: state.pathParameters['id']!,
          candidateId: state.pathParameters['candidateId']!,
        ),
      ),
    ],
  ),
];

/// Page de l'onglet « Mes missions ».
Widget buildPosterMissionsTab(BuildContext context) =>
    const MesMissionsScreen();
Widget buildPublishTab(BuildContext context) {
  return Center(
    child: FilledButton(
      onPressed: () => context.push(AppRoutes.posterPublishNew),
      child: const Text('Nouvelle mission'),
    ),
  );
}
