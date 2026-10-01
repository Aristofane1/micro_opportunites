import 'package:micro_opportunites/features/account/data/account_providers.dart';
import 'package:micro_opportunites/features/account/domain/entities/current_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_controller.g.dart';

@riverpod
Future<CurrentUser> currentUser(Ref ref) async =>
    (await ref.watch(accountRepositoryProvider).fetchCurrentUser())
        .getOrThrow();
