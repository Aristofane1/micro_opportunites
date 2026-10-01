import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/ui/sheet_page.dart';
import 'package:micro_opportunites/features/applications/presentation/pages/application_sent_page.dart';
import 'package:micro_opportunites/features/applications/presentation/pages/applications_page.dart';
import 'package:micro_opportunites/features/applications/presentation/pages/apply_sheet.dart';
import 'package:micro_opportunites/features/applications/presentation/pages/offer_page.dart';

/// Onglet Candidatures (B08).
Widget buildApplicationsTab(BuildContext context) => const ApplicationsPage();

final applicationsFullScreenRoutes = <RouteBase>[
  GoRoute(
    path: '/worker/missions/:id/apply',
    pageBuilder: (_, state) => SheetPage<void>(
      key: state.pageKey,
      child: ApplySheet(missionId: state.pathParameters['id']!),
    ),
  ),
  GoRoute(
    path: '/worker/applications/sent',
    builder: (_, state) => ApplicationSentPage(
      posterName: state.uri.queryParameters['poster'] ?? 'L’annonceur',
    ),
  ),
  GoRoute(
    path: '/worker/applications/:id/offer',
    builder: (_, state) =>
        OfferPage(applicationId: state.pathParameters['id']!),
  ),
];
