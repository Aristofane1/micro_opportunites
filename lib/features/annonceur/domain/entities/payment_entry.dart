enum PaymentKind { blocked, paid, refunded }

/// Une ligne de l'écran « Paiements ».
class PaymentEntry {
  const PaymentEntry({
    required this.id,
    required this.title,
    required this.kind,
    required this.amount,
    required this.date,
    this.people = 1,
    this.detail = '',
  });

  final String id;
  final String title; // nom de la mission
  final PaymentKind kind;
  final int amount; // toujours positif ; le signe dépend du type
  final DateTime date;
  final int people; // nombre de personnes payées
  final String detail;
}
