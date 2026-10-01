import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/routes/alerts_routes.dart';
import 'package:micro_opportunites/app/router/routes/applications_routes.dart';
import 'package:micro_opportunites/app/router/routes/assignments_routes.dart';
import 'package:micro_opportunites/app/router/routes/earnings_routes.dart';
import 'package:micro_opportunites/app/router/routes/missions_routes.dart';

/// Tous les écrans plein écran du module B (une ligne par feature).
final workerFullScreenRoutes = <RouteBase>[
  ...missionsFullScreenRoutes,
  ...applicationsFullScreenRoutes,
  ...assignmentsFullScreenRoutes,
  ...earningsFullScreenRoutes,
  ...alertsFullScreenRoutes,
];
