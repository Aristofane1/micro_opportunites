import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

Json publicAccount(Json user) => {
  'id': user['id'],
  'email': user['email'],
  'firstName': user['firstName'],
  'city': user['city'],
  'role': user['role'],
};

Object? login(FakeDatabase db, FakeRequest request) {
  final user = db.userByEmail(request.body['email'] as String? ?? '');
  if (user == null || user['password'] != request.body['password']) {
    throw const ApiException(422, 'E-mail ou mot de passe incorrect.');
  }
  db.sessionUserId = user['id'] as String;
  return publicAccount(user);
}

Object? signup(FakeDatabase db, FakeRequest request) {
  final email = (request.body['email'] as String? ?? '').trim().toLowerCase();
  final password = request.body['password'] as String? ?? '';
  if (!_emailPattern.hasMatch(email)) {
    throw const ApiException(422, 'Adresse e-mail invalide.');
  }
  if (password.length < 6) {
    throw const ApiException(422, 'Au moins 6 caractères.');
  }
  if (db.userByEmail(email) != null) {
    throw const ApiException(422, 'Un compte existe déjà avec cet e-mail.');
  }
  final id = db.newId('u');
  db.users[id] = {
    'id': id,
    'email': email,
    'password': password,
    'firstName': '',
    'lastName': '',
    'city': 'Abomey-Calavi',
    'lat': 6.4485,
    'lng': 2.3557,
    'role': null,
    'payoutAccount': {
      'operator': 'MTN MoMo',
      'maskedNumber': '•• •• •• ••',
      'holderName': '',
    },
  };
  db.sessionUserId = id;
  return publicAccount(db.users[id]!);
}

Object? logout(FakeDatabase db, FakeRequest request) {
  db.sessionUserId = null;
  return null;
}

Object? setRole(FakeDatabase db, FakeRequest request) {
  final role = request.body['role'];
  if (role != 'worker' && role != 'poster') {
    throw const ApiException(422, 'Rôle inconnu.');
  }
  final user = db.currentUser..['role'] = role;
  if (role == 'poster') {
    db.wallets.putIfAbsent(
      user['id'] as String,
      () => {'balance': 200000, 'blocked': <String, int>{}},
    );
    db.posters.putIfAbsent(
      user['id'] as String,
      () => {
        'id': user['id'],
        'displayName':
            '${user['firstName']} ${(user['lastName'] as String).isEmpty ? '' : '${(user['lastName'] as String)[0]}.'}'
                .trim(),
        'initials': (user['firstName'] as String).isEmpty
            ? '?'
            : (user['firstName'] as String)[0].toUpperCase(),
        'verified': false,
        'reliable': false,
        'city': user['city'],
        'memberSince': request.now.toUtc().toIso8601String(),
        'rating': 0.0,
        'reviewsCount': 0,
        'paidMissions': 0,
        'avgValidationHours': 0,
        'reviews': <Json>[],
      },
    );
  }
  return publicAccount(user);
}

Object? saveProfile(FakeDatabase db, FakeRequest request) {
  final body = request.body;
  final firstName = (body['firstName'] as String? ?? '').trim();
  final lastName = (body['lastName'] as String? ?? '').trim();
  if (firstName.isEmpty || lastName.isEmpty) {
    throw const ApiException(422, 'Prénom et nom sont obligatoires.');
  }
  if (body['acceptTerms'] != true) {
    throw const ApiException(
      422,
      'Vous devez accepter les conditions générales.',
    );
  }
  final birthDate = DateTime.tryParse(body['birthDate'] as String? ?? '');
  if (birthDate == null) {
    throw const ApiException(422, 'Date de naissance invalide.');
  }
  final now = request.now.toUtc();
  var age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  if (age < 18) {
    throw const ApiException(422, 'Vous devez avoir au moins 18 ans.');
  }
  final user = db.currentUser;
  user['firstName'] = firstName;
  user['lastName'] = '${lastName.substring(0, 1).toUpperCase()}.';
  user['birthDate'] = body['birthDate'];
  user['newsletter'] = body['acceptNewsletter'] == true;
  return {
    'firstName': firstName,
    'lastName': lastName,
    'birthDate': body['birthDate'],
  };
}

Object? submitKyc(FakeDatabase db, FakeRequest request) {
  final body = request.body;
  if (body['frontCaptured'] != true || body['backCaptured'] != true) {
    throw const ApiException(422, 'Photographiez le recto et le verso.');
  }
  db.kyc = {
    'status': 'pending',
    'documentType': body['documentType'],
    'countryCode': body['countryCode'],
    'submittedAt': request.now.toUtc().toIso8601String(),
  };
  return {'status': 'pending', 'submittedAt': db.kyc!['submittedAt']};
}

Object? getKyc(FakeDatabase db, FakeRequest request) {
  final kyc = db.kyc;
  return kyc == null
      ? {'status': 'none', 'submittedAt': null}
      : {'status': kyc['status'], 'submittedAt': kyc['submittedAt']};
}
