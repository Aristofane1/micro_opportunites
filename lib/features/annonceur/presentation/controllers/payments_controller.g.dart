// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Historique des paiements (SIMULATION, en mémoire).
/// À REMPLACER par Firestore quand Firebase sera branché.

@ProviderFor(PaymentsController)
final paymentsControllerProvider = PaymentsControllerProvider._();

/// Historique des paiements (SIMULATION, en mémoire).
/// À REMPLACER par Firestore quand Firebase sera branché.
final class PaymentsControllerProvider
    extends $NotifierProvider<PaymentsController, List<PaymentEntry>> {
  /// Historique des paiements (SIMULATION, en mémoire).
  /// À REMPLACER par Firestore quand Firebase sera branché.
  PaymentsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentsControllerHash();

  @$internal
  @override
  PaymentsController create() => PaymentsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PaymentEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PaymentEntry>>(value),
    );
  }
}

String _$paymentsControllerHash() =>
    r'75b572f07d6aafb7624d07b91de42d079d21ae36';

/// Historique des paiements (SIMULATION, en mémoire).
/// À REMPLACER par Firestore quand Firebase sera branché.

abstract class _$PaymentsController extends $Notifier<List<PaymentEntry>> {
  List<PaymentEntry> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<PaymentEntry>, List<PaymentEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<PaymentEntry>, List<PaymentEntry>>,
              List<PaymentEntry>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
