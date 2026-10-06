import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/app/router/routes/alerts_routes.dart';
import 'package:micro_opportunites/app/router/routes/applications_routes.dart';
import 'package:micro_opportunites/app/router/routes/earnings_routes.dart';
import 'package:micro_opportunites/app/router/routes/missions_routes.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/ui/widgets/app_navigation_bar.dart';
import 'package:micro_opportunites/app/router/routes/poster_routes.dart';

class ShellTab {
  const ShellTab({
    required this.path,
    required this.label,
    required this.icon,
    this.builder,
    this.routes = const [],
  });

  final String path;
  final String label;
  final AppIcons icon;

  /// Construit la page de l'onglet ; `null` affiche la page par défaut
  /// (`PlaceholderPage`).
  final WidgetBuilder? builder;

  /// Sous-routes de l'onglet (ex. détail poussé depuis sa liste).
  final List<RouteBase> routes;

  AppNavigationItem get navigationItem =>
      AppNavigationItem(icon: icon, label: label);
}

final workerTabs = <ShellTab>[
  ShellTab(
    path: AppRoutes.workerExplore,
    label: 'Explorer',
    icon: AppIcons.explore,
    builder: buildExploreTab,
    routes: exploreTabRoutes,
  ),
  const ShellTab(
    path: AppRoutes.workerApplications,
    label: 'Candidatures',
    icon: AppIcons.applications,
    builder: buildApplicationsTab,
  ),
  const ShellTab(
    path: AppRoutes.workerEarnings,
    label: 'Gains',
    icon: AppIcons.earnings,
    builder: buildEarningsTab,
  ),
  const ShellTab(
    path: AppRoutes.workerMessages,
    label: 'Messages',
    icon: AppIcons.messages,
  ),
  const ShellTab(
    path: AppRoutes.workerProfile,
    label: 'Moi',
    icon: AppIcons.profile,
    builder: buildWorkerProfileTab,
  ),
];

final posterTabs = <ShellTab>[
  ShellTab(
    path: AppRoutes.posterMissions,
    label: 'Mes missions',
    icon: AppIcons.missions,
    builder: buildPosterMissionsTab,
    routes: posterMissionsTabRoutes,
  ),
  const ShellTab(
    path: AppRoutes.posterPublish,
    label: 'Publier',
    icon: AppIcons.publish,
    builder: buildPublishTab,
  ),
  const ShellTab(
    path: AppRoutes.posterPayments,
    label: 'Paiements',
    icon: AppIcons.securePayment,
  ),
  const ShellTab(
    path: AppRoutes.posterMessages,
    label: 'Messages',
    icon: AppIcons.messages,
  ),
  const ShellTab(
    path: AppRoutes.posterProfile,
    label: 'Moi',
    icon: AppIcons.profile,
  ),
];
