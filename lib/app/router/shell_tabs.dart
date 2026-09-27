import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/ui/widgets/app_navigation_bar.dart';

class ShellTab {
  const ShellTab({
    required this.path,
    required this.label,
    required this.icon,
    this.isProfile = false,
    this.builder,
    this.routes = const [],
  });

  final String path;
  final String label;
  final AppIcons icon;
  final bool isProfile;

  /// Construit la page de l'onglet ; `null` affiche la page par défaut
  /// (`PlaceholderPage`).
  final WidgetBuilder? builder;

  /// Sous-routes de l'onglet (ex. détail poussé depuis sa liste).
  final List<RouteBase> routes;

  AppNavigationItem get navigationItem =>
      AppNavigationItem(icon: icon, label: label);
}

const workerTabs = <ShellTab>[
  ShellTab(
    path: AppRoutes.workerExplore,
    label: 'Explorer',
    icon: AppIcons.explore,
  ),
  ShellTab(
    path: AppRoutes.workerApplications,
    label: 'Candidatures',
    icon: AppIcons.applications,
  ),
  ShellTab(
    path: AppRoutes.workerEarnings,
    label: 'Gains',
    icon: AppIcons.earnings,
  ),
  ShellTab(
    path: AppRoutes.workerMessages,
    label: 'Messages',
    icon: AppIcons.messages,
  ),
  ShellTab(
    path: AppRoutes.workerProfile,
    label: 'Moi',
    icon: AppIcons.profile,
    isProfile: true,
  ),
];

const posterTabs = <ShellTab>[
  ShellTab(
    path: AppRoutes.posterMissions,
    label: 'Mes missions',
    icon: AppIcons.missions,
  ),
  ShellTab(
    path: AppRoutes.posterPublish,
    label: 'Publier',
    icon: AppIcons.publish,
  ),
  ShellTab(
    path: AppRoutes.posterPayments,
    label: 'Paiements',
    icon: AppIcons.securePayment,
  ),
  ShellTab(
    path: AppRoutes.posterMessages,
    label: 'Messages',
    icon: AppIcons.messages,
  ),
  ShellTab(
    path: AppRoutes.posterProfile,
    label: 'Moi',
    icon: AppIcons.profile,
    isProfile: true,
  ),
];
