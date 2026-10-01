// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myAlerts)
final myAlertsProvider = MyAlertsProvider._();

final class MyAlertsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MissionAlert>>,
          List<MissionAlert>,
          FutureOr<List<MissionAlert>>
        >
    with
        $FutureModifier<List<MissionAlert>>,
        $FutureProvider<List<MissionAlert>> {
  MyAlertsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAlertsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAlertsHash();

  @$internal
  @override
  $FutureProviderElement<List<MissionAlert>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MissionAlert>> create(Ref ref) {
    return myAlerts(ref);
  }
}

String _$myAlertsHash() => r'c4be749613520774ccff47f687102a7c10208ccd';

/// keepAlive : sans abonné, le notifier serait détruit pendant l'action.

@ProviderFor(AlertActions)
final alertActionsProvider = AlertActionsProvider._();

/// keepAlive : sans abonné, le notifier serait détruit pendant l'action.
final class AlertActionsProvider
    extends $AsyncNotifierProvider<AlertActions, void> {
  /// keepAlive : sans abonné, le notifier serait détruit pendant l'action.
  AlertActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertActionsHash();

  @$internal
  @override
  AlertActions create() => AlertActions();
}

String _$alertActionsHash() => r'd79b2e63154a11e8a3afbb8cdd6070dceac1538f';

/// keepAlive : sans abonné, le notifier serait détruit pendant l'action.

abstract class _$AlertActions extends $AsyncNotifier<void> {
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
