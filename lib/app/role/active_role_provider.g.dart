// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_role_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rôle actif, gardé en mémoire (persistance ajoutée avec la feature profil).

@ProviderFor(ActiveRoleNotifier)
final activeRoleProvider = ActiveRoleNotifierProvider._();

/// Rôle actif, gardé en mémoire (persistance ajoutée avec la feature profil).
final class ActiveRoleNotifierProvider
    extends $NotifierProvider<ActiveRoleNotifier, ActiveRole> {
  /// Rôle actif, gardé en mémoire (persistance ajoutée avec la feature profil).
  ActiveRoleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeRoleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeRoleNotifierHash();

  @$internal
  @override
  ActiveRoleNotifier create() => ActiveRoleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveRole value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveRole>(value),
    );
  }
}

String _$activeRoleNotifierHash() =>
    r'8047086475d9a796f3a3de033aff7bb2f6f150ff';

/// Rôle actif, gardé en mémoire (persistance ajoutée avec la feature profil).

abstract class _$ActiveRoleNotifier extends $Notifier<ActiveRole> {
  ActiveRole build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ActiveRole, ActiveRole>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActiveRole, ActiveRole>,
              ActiveRole,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
