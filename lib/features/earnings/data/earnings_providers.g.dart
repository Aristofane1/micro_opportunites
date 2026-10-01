// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earningsRepository)
final earningsRepositoryProvider = EarningsRepositoryProvider._();

final class EarningsRepositoryProvider
    extends
        $FunctionalProvider<
          EarningsRepository,
          EarningsRepository,
          EarningsRepository
        >
    with $Provider<EarningsRepository> {
  EarningsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earningsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earningsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EarningsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarningsRepository create(Ref ref) {
    return earningsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarningsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarningsRepository>(value),
    );
  }
}

String _$earningsRepositoryHash() =>
    r'2e658a26cfa444f3ad4250f0ed9dfdd80bacc295';
