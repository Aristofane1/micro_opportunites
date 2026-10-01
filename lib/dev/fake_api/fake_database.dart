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

  int _sequence = 100;

  Json get currentUser => users[currentUserId]!;

  String newId(String prefix) => '$prefix${_sequence++}';
}
