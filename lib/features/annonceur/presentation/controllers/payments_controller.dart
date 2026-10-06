import 'package:micro_opportunites/core/dev/dev_start.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payments_controller.g.dart';

/// Historique des paiements (SIMULATION, en mémoire).
/// À REMPLACER par Firestore quand Firebase sera branché.
@Riverpod(keepAlive: true)
class PaymentsController extends _$PaymentsController {
  @override
  List<PaymentEntry> build() => startOnPublish ? _demoPayments() : const [];

  void addPaid({
    required String missionTitle,
    required String workerName,
    required int amount,
  }) {
    state = [
      PaymentEntry(
        id: 'paid-${DateTime.now().microsecondsSinceEpoch}',
        title: missionTitle,
        kind: PaymentKind.paid,
        amount: amount,
        date: DateTime.now(),
        detail: 'Versé à $workerName',
      ),
      ...state,
    ];
  }

  void addRefund({
    required String missionTitle,
    required int amount,
    required String reason,
  }) {
    if (amount <= 0) return;
    state = [
      PaymentEntry(
        id: 'refund-${DateTime.now().microsecondsSinceEpoch}',
        title: missionTitle,
        kind: PaymentKind.refunded,
        amount: amount,
        date: DateTime.now(),
        detail: reason,
      ),
      ...state,
    ];
  }
}

// Exemples (seulement avec START=publish). Datés du 1er du mois pour
// toujours compter dans « Versé ce mois-ci ».
List<PaymentEntry> _demoPayments() {
  final now = DateTime.now();
  final monthStart = DateTime(now.year, now.month, 1);
  return [
    PaymentEntry(
      id: 'demo-p1',
      title: 'Aide au déménagement',
      kind: PaymentKind.paid,
      amount: 18000,
      date: monthStart,
      people: 3,
      detail: 'Versé à 3 personnes',
    ),
    PaymentEntry(
      id: 'demo-p2',
      title: 'Livraison de colis',
      kind: PaymentKind.paid,
      amount: 23000,
      date: monthStart,
      people: 6,
      detail: 'Versé à 6 personnes',
    ),
    PaymentEntry(
      id: 'demo-p3',
      title: 'Courses au marché',
      kind: PaymentKind.refunded,
      amount: 2000,
      date: monthStart,
      detail: 'Remboursé · mission expirée',
    ),
  ];
}
