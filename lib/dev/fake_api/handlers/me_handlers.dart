import 'package:micro_opportunites/dev/fake_api/fake_database.dart';
import 'package:micro_opportunites/dev/fake_api/fake_routing.dart';
import 'package:micro_opportunites/dev/fake_api/handlers/auth_handlers.dart';

Object? getMe(FakeDatabase db, FakeRequest request) =>
    publicAccount(db.currentUser);
