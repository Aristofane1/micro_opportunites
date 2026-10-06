// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonceur_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Les missions avec leurs compteurs calculés à partir des candidats.
/// C'est CETTE liste que les écrans doivent lire.

@ProviderFor(missionsWithCounts)
final missionsWithCountsProvider = MissionsWithCountsProvider._();

/// Les missions avec leurs compteurs calculés à partir des candidats.
/// C'est CETTE liste que les écrans doivent lire.

final class MissionsWithCountsProvider
    extends
        $FunctionalProvider<
          List<MissionSummary>,
          List<MissionSummary>,
          List<MissionSummary>
        >
    with $Provider<List<MissionSummary>> {
  /// Les missions avec leurs compteurs calculés à partir des candidats.
  /// C'est CETTE liste que les écrans doivent lire.
  MissionsWithCountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'missionsWithCountsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$missionsWithCountsHash();

  @$internal
  @override
  $ProviderElement<List<MissionSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<MissionSummary> create(Ref ref) {
    return missionsWithCounts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MissionSummary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MissionSummary>>(value),
    );
  }
}

String _$missionsWithCountsHash() =>
    r'c1c292c4ca7f5dc0aa9dc30bdf29f6acb91370e4';

@ProviderFor(pendingValidations)
final pendingValidationsProvider = PendingValidationsProvider._();

final class PendingValidationsProvider
    extends
        $FunctionalProvider<
          List<PendingValidation>,
          List<PendingValidation>,
          List<PendingValidation>
        >
    with $Provider<List<PendingValidation>> {
  PendingValidationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingValidationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingValidationsHash();

  @$internal
  @override
  $ProviderElement<List<PendingValidation>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PendingValidation> create(Ref ref) {
    return pendingValidations(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PendingValidation> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PendingValidation>>(value),
    );
  }
}

String _$pendingValidationsHash() =>
    r'2fe987256040d8adef9517581c2ca5d09352539c';

/// Les lignes de l'écran Paiements : l'argent bloqué (calculé à partir des
/// missions actives) + les paiements déjà faits, du plus récent au plus ancien.

@ProviderFor(paymentRows)
final paymentRowsProvider = PaymentRowsProvider._();

/// Les lignes de l'écran Paiements : l'argent bloqué (calculé à partir des
/// missions actives) + les paiements déjà faits, du plus récent au plus ancien.

final class PaymentRowsProvider
    extends
        $FunctionalProvider<
          List<PaymentEntry>,
          List<PaymentEntry>,
          List<PaymentEntry>
        >
    with $Provider<List<PaymentEntry>> {
  /// Les lignes de l'écran Paiements : l'argent bloqué (calculé à partir des
  /// missions actives) + les paiements déjà faits, du plus récent au plus ancien.
  PaymentRowsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paymentRowsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paymentRowsHash();

  @$internal
  @override
  $ProviderElement<List<PaymentEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PaymentEntry> create(Ref ref) {
    return paymentRows(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PaymentEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PaymentEntry>>(value),
    );
  }
}

String _$paymentRowsHash() => r'0f443976134866249b060956150bb7f1e531ff5e';
