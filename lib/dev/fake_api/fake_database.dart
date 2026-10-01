typedef Json = Map<String, dynamic>;

/// Tables JSON mutables du faux serveur (comme des collections Firestore).
class FakeDatabase {
  FakeDatabase({required this.currentUserId});

  final String currentUserId;
  final users = <String, Json>{};
  final posters = <String, Json>{};
  final missions = <String, Json>{};
  final applications = <String, Json>{};
  final assignments = <String, Json>{};
  final payouts = <String, Json>{};
  final alerts = <String, Json>{};

  /// Demandes de code SMS en cours, par requestId.
  final authRequests = <String, Json>{};

  /// Dossier KYC de l'utilisateur courant (null tant que rien n'est soumis).
  Json? kyc;

  int _sequence = 100;

  Json get currentUser => users[currentUserId]!;

  String newId(String prefix) => '$prefix${_sequence++}';
}
