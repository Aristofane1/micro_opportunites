import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/formatting/money.dart';
import 'package:micro_opportunites/features/earnings/domain/entities/earnings_summary.dart';
import 'package:micro_opportunites/features/earnings/presentation/controllers/earnings_controller.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  test('résumé : à venir, versés sur 30 jours, historique', () async {
    final container = createTestContainer();
    final summary = await container.read(earningsSummaryProvider.future);
    expect(summary.upcomingAmount, 5000);
    expect(summary.upcomingCount, 1);
    expect(summary.paidAmount, 32000);
    expect(summary.paidCount, 6);
    expect(summary.payoutAccount.maskedNumber, '01 97 •• •• 45');
    expect(summary.lines, hasLength(7));
    expect(summary.lines.first.status, EarningStatus.reserved);
  });

  test('reçu de versement', () async {
    final container = createTestContainer();
    final payout = await container.read(payoutProvider('po1').future);
    expect(payout.reference, 'MO-2026-004812');
    expect(payout.missionTitle, 'Configurer une box internet');
  });

  testWidgets('B14 → B15 : ouvrir un reçu', (tester) async {
    await pumpWorkerApp(tester);
    await tester.tap(find.text('Gains'));
    await tester.pumpAndSettle();
    expect(find.text('Mes gains'), findsOneWidget);
    expect(find.text(formatAmount(32000)), findsOneWidget);
    await tester.tap(find.text('Configurer une box internet'));
    await tester.pumpAndSettle();
    expect(find.text('Reçu de versement'), findsOneWidget);
    expect(find.text('MO-2026-004812'), findsOneWidget);
    expect(find.text('Commission'), findsOneWidget);
    expect(find.text('Aucune (démo)'), findsOneWidget);
  });
}
