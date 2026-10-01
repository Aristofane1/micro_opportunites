import 'package:micro_opportunites/core/network/api_exception.dart';
import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';

Object? listAlerts(FakeDatabase db, FakeRequest request) =>
    db.alerts.values.toList();

Object? createAlert(FakeDatabase db, FakeRequest request) {
  final body = request.body;
  final zone = (body['zone'] as String?)?.trim() ?? '';
  final days = (body['days'] as String?)?.trim() ?? '';
  if (zone.isEmpty || days.isEmpty) {
    throw const ApiException(422, 'Choisissez une zone et des jours.');
  }
  final id = db.newId('al');
  db.alerts[id] = {
    'id': id,
    'keyword': body['keyword'],
    'category': body['category'],
    'zone': zone,
    'minPay': body['minPay'],
    'days': days,
  };
  return db.alerts[id];
}

Object? deleteAlert(FakeDatabase db, FakeRequest request) {
  final removed = db.alerts.remove(request.params['id']);
  if (removed == null) throw const ApiException(404, 'Alerte introuvable.');
  return null;
}
