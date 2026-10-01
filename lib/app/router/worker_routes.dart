import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/routes/alerts_routes.dart';
import 'package:micro_opportunites/app/router/routes/applications_routes.dart';
import 'package:micro_opportunites/app/router/routes/assignments_routes.dart';
import 'package:micro_opportunites/app/router/routes/earnings_routes.dart';
import 'package:micro_opportunites/app/router/routes/entry_routes.dart';
import 'package:micro_opportunites/app/router/routes/missions_routes.dart';

/// Écrans plein écran : entrée (module A) et module B (une ligne par feature).
final workerFullScreenRoutes = <RouteBase>[
  ...entryRoutes,
  ...missionsFullScreenRoutes,
  ...applicationsFullScreenRoutes,
  ...assignmentsFullScreenRoutes,
  ...earningsFullScreenRoutes,
  ...alertsFullScreenRoutes,
];
