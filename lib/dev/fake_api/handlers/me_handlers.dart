import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';

Object? getMe(FakeDatabase db, FakeRequest request) {
  final user = db.currentUser;
  return {
    'id': user['id'],
    'firstName': user['firstName'],
    'city': user['city'],
  };
}
