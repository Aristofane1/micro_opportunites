import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/features/earnings/presentation/pages/earnings_page.dart';
import 'package:micro_opportunites/features/earnings/presentation/pages/receipt_page.dart';

/// Onglet Gains (B14).
Widget buildEarningsTab(BuildContext context) => const EarningsPage();

final earningsFullScreenRoutes = <RouteBase>[
  GoRoute(
    path: '/worker/payouts/:id',
    builder: (_, state) => ReceiptPage(payoutId: state.pathParameters['id']!),
  ),
];
