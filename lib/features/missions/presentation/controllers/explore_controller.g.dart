// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Liste d'Explorer (B01) selon les filtres courants.

@ProviderFor(exploreMissions)
final exploreMissionsProvider = ExploreMissionsProvider._();

/// Liste d'Explorer (B01) selon les filtres courants.

final class ExploreMissionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MissionPage>,
          MissionPage,
          FutureOr<MissionPage>
        >
    with $FutureModifier<MissionPage>, $FutureProvider<MissionPage> {
  /// Liste d'Explorer (B01) selon les filtres courants.
  ExploreMissionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreMissionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreMissionsHash();

  @$internal
  @override
  $FutureProviderElement<MissionPage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MissionPage> create(Ref ref) {
    return exploreMissions(ref);
  }
}

String _$exploreMissionsHash() => r'74b795953d3b2deaeddd28fe7fc3e8e3ecd93034';

/// Résultats d'une recherche texte (B04 quand vide), filtres courants inclus.

@ProviderFor(searchMissions)
final searchMissionsProvider = SearchMissionsFamily._();

/// Résultats d'une recherche texte (B04 quand vide), filtres courants inclus.

final class SearchMissionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MissionPage>,
          MissionPage,
          FutureOr<MissionPage>
        >
    with $FutureModifier<MissionPage>, $FutureProvider<MissionPage> {
  /// Résultats d'une recherche texte (B04 quand vide), filtres courants inclus.
  SearchMissionsProvider._({
    required SearchMissionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchMissionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchMissionsHash();

  @override
  String toString() {
    return r'searchMissionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MissionPage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MissionPage> create(Ref ref) {
    final argument = this.argument as String;
    return searchMissions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchMissionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchMissionsHash() => r'be69f797e59519c47c6f13bf7fbb9381bcabed23';

/// Résultats d'une recherche texte (B04 quand vide), filtres courants inclus.

final class SearchMissionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MissionPage>, String> {
  SearchMissionsFamily._()
    : super(
        retry: null,
        name: r'searchMissionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Résultats d'une recherche texte (B04 quand vide), filtres courants inclus.

  SearchMissionsProvider call(String query) =>
      SearchMissionsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchMissionsProvider';
}

/// Compte en direct du bouton « Voir N missions » de la feuille Filtres.

@ProviderFor(filtersPreviewCount)
final filtersPreviewCountProvider = FiltersPreviewCountFamily._();

/// Compte en direct du bouton « Voir N missions » de la feuille Filtres.

final class FiltersPreviewCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Compte en direct du bouton « Voir N missions » de la feuille Filtres.
  FiltersPreviewCountProvider._({
    required FiltersPreviewCountFamily super.from,
    required MissionFilters super.argument,
  }) : super(
         retry: null,
         name: r'filtersPreviewCountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filtersPreviewCountHash();

  @override
  String toString() {
    return r'filtersPreviewCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    final argument = this.argument as MissionFilters;
    return filtersPreviewCount(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FiltersPreviewCountProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filtersPreviewCountHash() =>
    r'14254858f3dfe6b778685900ef5758a8de8aca70';

/// Compte en direct du bouton « Voir N missions » de la feuille Filtres.

final class FiltersPreviewCountFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int>, MissionFilters> {
  FiltersPreviewCountFamily._()
    : super(
        retry: null,
        name: r'filtersPreviewCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Compte en direct du bouton « Voir N missions » de la feuille Filtres.

  FiltersPreviewCountProvider call(MissionFilters draft) =>
      FiltersPreviewCountProvider._(argument: draft, from: this);

  @override
  String toString() => r'filtersPreviewCountProvider';
}

/// Pastilles par ville de la carte (B02).

@ProviderFor(missionMap)
final missionMapProvider = MissionMapProvider._();

/// Pastilles par ville de la carte (B02).

final class MissionMapProvider
    extends
        $FunctionalProvider<
          AsyncValue<MissionMap>,
          MissionMap,
          FutureOr<MissionMap>
        >
    with $FutureModifier<MissionMap>, $FutureProvider<MissionMap> {
  /// Pastilles par ville de la carte (B02).
  MissionMapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'missionMapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$missionMapHash();

  @$internal
  @override
  $FutureProviderElement<MissionMap> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<MissionMap> create(Ref ref) {
    return missionMap(ref);
  }
}

String _$missionMapHash() => r'21a33c9995af51cc7e44b753cfccb01be6611e9b';
