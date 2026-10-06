import 'package:micro_opportunites/core/network/api_exception.dart';

typedef Json = Map<String, dynamic>;

/// Tables JSON mutables du faux serveur (comme des collections Firestore).
class FakeDatabase {
  FakeDatabase({this.sessionUserId});

  /// Compte connecté ; `null` après « Se déconnecter ».
  String? sessionUserId;

  final users = <String, Json>{};
  final posters = <String, Json>{};
  final missions = <String, Json>{};
  final applications = <String, Json>{};
  final assignments = <String, Json>{};
  final payouts = <String, Json>{};
  final alerts = <String, Json>{};

  /// Portefeuille de chaque annonceur : solde et montants bloqués par mission.
  final wallets = <String, Json>{};

  int _sequence = 100;

  String get currentUserId =>
      sessionUserId ??
      (throw const ApiException(
        401,
        'Votre session a expiré. Reconnectez-vous.',
      ));

  Json get currentUser => users[currentUserId]!;

  Json? userByEmail(String email) {
    final wanted = email.trim().toLowerCase();
    for (final user in users.values) {
      if ((user['email'] as String?)?.toLowerCase() == wanted) return user;
    }
    return null;
  }

  String newId(String prefix) => '$prefix${_sequence++}';
}
