import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/placeholder_page.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';
import 'package:micro_opportunites/features/alerts/presentation/pages/alerts_page.dart';

/// Onglet « Moi » (module D, pas encore construit) : lien vers les alertes.
Widget buildWorkerProfileTab(BuildContext context) => PlaceholderPage(
  title: 'Moi',
  links: [PlaceholderLink(label: 'Mes alertes', path: WorkerPaths.alerts())],
);

final alertsFullScreenRoutes = <RouteBase>[
  GoRoute(
    path: '/worker/alerts',
    builder: (_, state) =>
        AlertsPage(initialKeyword: state.uri.queryParameters['q']),
  ),
];
