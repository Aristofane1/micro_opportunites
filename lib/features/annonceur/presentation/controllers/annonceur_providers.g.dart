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
