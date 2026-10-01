// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(alertsRepository)
final alertsRepositoryProvider = AlertsRepositoryProvider._();

final class AlertsRepositoryProvider
    extends
        $FunctionalProvider<
          AlertsRepository,
          AlertsRepository,
          AlertsRepository
        >
    with $Provider<AlertsRepository> {
  AlertsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AlertsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AlertsRepository create(Ref ref) {
    return alertsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlertsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlertsRepository>(value),
    );
  }
}

String _$alertsRepositoryHash() => r'5b86adf80babc6f501202f1a29d6d947ee891332';
