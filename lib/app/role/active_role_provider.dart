import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:micro_opportunites/core/dev/dev_start.dart';

part 'active_role_provider.g.dart';

/// Rôle actif, gardé en mémoire (persistance ajoutée avec la feature profil).
@Riverpod(keepAlive: true)
class ActiveRoleNotifier extends _$ActiveRoleNotifier {
  @override
  ActiveRole build() => startOnPublish ? ActiveRole.poster : ActiveRole.worker;

  void switchTo(ActiveRole role) {
    if (state == role) return;
    state = role;
  }
}
