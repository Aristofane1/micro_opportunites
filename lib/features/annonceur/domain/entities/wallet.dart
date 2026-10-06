/// Solde de l'annonceur : total, disponible, montants bloqués par mission
/// et paiements déjà versés.
class Wallet {
  const Wallet({
    required this.balance,
    required this.available,
    required this.blocked,
    required this.payouts,
  });

  final int balance;
  final int available;
  final List<BlockedAmount> blocked;
  final List<PosterPayout> payouts;
}

/// Argent bloqué pour une mission publiée.
class BlockedAmount {
  const BlockedAmount({
    required this.missionId,
    required this.title,
    required this.amount,
  });

  final String missionId;
  final String title;
  final int amount;
}

/// Paiement versé à un exécutant.
class PosterPayout {
  const PosterPayout({
    required this.id,
    required this.missionTitle,
    required this.workerName,
    required this.amount,
    required this.paidAt,
  });

  final String id;
  final String missionTitle;
  final String workerName;
  final int amount;
  final DateTime paidAt;
}
