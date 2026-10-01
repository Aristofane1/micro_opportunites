// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_tiles.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Faux dans les tests : pas de requêtes de tuiles.

@ProviderFor(mapTilesEnabled)
final mapTilesEnabledProvider = MapTilesEnabledProvider._();

/// Faux dans les tests : pas de requêtes de tuiles.

final class MapTilesEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Faux dans les tests : pas de requêtes de tuiles.
  MapTilesEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapTilesEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapTilesEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return mapTilesEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$mapTilesEnabledHash() => r'8712b00fd4954719d912684636e5f21401fa53b0';
