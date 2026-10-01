// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_filters_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Filtres courants d'Explorer, partagés par la liste, la feuille Filtres,
/// la carte et la recherche. Conservés tant que l'app tourne.

@ProviderFor(MissionFiltersController)
final missionFiltersControllerProvider = MissionFiltersControllerProvider._();

/// Filtres courants d'Explorer, partagés par la liste, la feuille Filtres,
/// la carte et la recherche. Conservés tant que l'app tourne.
final class MissionFiltersControllerProvider
    extends $NotifierProvider<MissionFiltersController, MissionFilters> {
  /// Filtres courants d'Explorer, partagés par la liste, la feuille Filtres,
  /// la carte et la recherche. Conservés tant que l'app tourne.
  MissionFiltersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'missionFiltersControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$missionFiltersControllerHash();

  @$internal
  @override
  MissionFiltersController create() => MissionFiltersController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MissionFilters value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MissionFilters>(value),
    );
  }
}

String _$missionFiltersControllerHash() =>
    r'3c1316acbbcb1dbbd527daeaf3e34b867b2d6d15';

/// Filtres courants d'Explorer, partagés par la liste, la feuille Filtres,
/// la carte et la recherche. Conservés tant que l'app tourne.

abstract class _$MissionFiltersController extends $Notifier<MissionFilters> {
  MissionFilters build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MissionFilters, MissionFilters>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MissionFilters, MissionFilters>,
              MissionFilters,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
