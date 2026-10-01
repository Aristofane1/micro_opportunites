import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';

/// Code SMS accepté par le faux serveur (affiché dans l'app en démo).
const demoSmsCode = '12345';

Object? requestPhoneCode(FakeDatabase db, FakeRequest request) {
  final phone = (request.body['phone'] as String? ?? '').replaceAll(' ', '');
  final digits = phone.replaceAll(RegExp(r'\D'), '');
  if (digits.length < 8) {
    throw const ApiException(422, 'Numéro de téléphone invalide.');
  }
  final requestId = db.newId('otp');
  db.authRequests[requestId] = {'phone': phone, 'code': demoSmsCode};
  return {
    'requestId': requestId,
    'demoCode': demoSmsCode,
    'maskedPhone': '${phone.substring(0, 4)} •• •• •• ${phone.substring(phone.length - 2)}',
  };
}

Object? verifyPhoneCode(FakeDatabase db, FakeRequest request) {
  final pending = db.authRequests[request.body['requestId']];
  if (pending == null) throw const ApiException(404, 'Demande introuvable.');
  if (request.body['code'] != pending['code']) {
    throw const ApiException(422, 'Code incorrect.');
  }
  db.currentUser['phone'] = pending['phone'];
  return {'userId': db.currentUserId};
}

Object? saveProfile(FakeDatabase db, FakeRequest request) {
  final body = request.body;
  final firstName = (body['firstName'] as String? ?? '').trim();
  final lastName = (body['lastName'] as String? ?? '').trim();
  if (firstName.isEmpty || lastName.isEmpty) {
    throw const ApiException(422, 'Prénom et nom sont obligatoires.');
  }
  if (body['acceptTerms'] != true) {
    throw const ApiException(422, 'Vous devez accepter les conditions générales.');
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
  if (age < 18) throw const ApiException(422, 'Vous devez avoir au moins 18 ans.');
  final user = db.currentUser;
  user['firstName'] = firstName;
  user['lastName'] = '${lastName.substring(0, 1).toUpperCase()}.';
  user['birthDate'] = body['birthDate'];
  user['newsletter'] = body['acceptNewsletter'] == true;
  return {'firstName': firstName, 'lastName': lastName, 'birthDate': body['birthDate']};
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
