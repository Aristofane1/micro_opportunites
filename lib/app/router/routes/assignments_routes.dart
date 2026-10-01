import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/features/assignments/presentation/pages/assignment_page.dart';
import 'package:micro_opportunites/features/assignments/presentation/pages/report_end_page.dart';

final assignmentsFullScreenRoutes = <RouteBase>[
  GoRoute(
    path: '/worker/assignments/:id',
    builder: (_, state) =>
        AssignmentPage(assignmentId: state.pathParameters['id']!),
  ),
  GoRoute(
    path: '/worker/assignments/:id/report-end',
    builder: (_, state) =>
        ReportEndPage(assignmentId: state.pathParameters['id']!),
  ),
];
