import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/account/domain/entities/current_user.dart';

abstract interface class AccountRepository {
  Future<Result<CurrentUser>> fetchCurrentUser();
}
