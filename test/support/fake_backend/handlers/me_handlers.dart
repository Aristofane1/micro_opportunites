import '../fake_database.dart';
import '../fake_routing.dart';
import 'auth_handlers.dart';

Object? getMe(FakeDatabase db, FakeRequest request) =>
    publicAccount(db.currentUser);
