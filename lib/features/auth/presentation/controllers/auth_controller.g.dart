// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kycState)
final kycStateProvider = KycStateProvider._();

final class KycStateProvider
    extends
        $FunctionalProvider<AsyncValue<KycState>, KycState, FutureOr<KycState>>
    with $FutureModifier<KycState>, $FutureProvider<KycState> {
  KycStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kycStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kycStateHash();

  @$internal
  @override
  $FutureProviderElement<KycState> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<KycState> create(Ref ref) {
    return kycState(ref);
  }
}

String _$kycStateHash() => r'30849642ab826e02b978c41303fe67080c2a6d1d';

/// Actions du parcours d'entrée. Gardé en vie : en autoDispose, le
/// notifier peut être détruit pendant l'appel réseau.

@ProviderFor(AuthActions)
final authActionsProvider = AuthActionsProvider._();

/// Actions du parcours d'entrée. Gardé en vie : en autoDispose, le
/// notifier peut être détruit pendant l'appel réseau.
final class AuthActionsProvider
    extends $AsyncNotifierProvider<AuthActions, void> {
  /// Actions du parcours d'entrée. Gardé en vie : en autoDispose, le
  /// notifier peut être détruit pendant l'appel réseau.
  AuthActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authActionsHash();

  @$internal
  @override
  AuthActions create() => AuthActions();
}

String _$authActionsHash() => r'539492e0477fe9c067b8bbdeebcceb88ffe9ae14';

/// Actions du parcours d'entrée. Gardé en vie : en autoDispose, le
/// notifier peut être détruit pendant l'appel réseau.

abstract class _$AuthActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
