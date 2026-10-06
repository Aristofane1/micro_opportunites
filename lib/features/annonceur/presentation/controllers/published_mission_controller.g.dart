// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'published_mission_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PublishedMissionController)
final publishedMissionControllerProvider =
    PublishedMissionControllerProvider._();

final class PublishedMissionControllerProvider
    extends $NotifierProvider<PublishedMissionController, PublishedMission?> {
  PublishedMissionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publishedMissionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publishedMissionControllerHash();

  @$internal
  @override
  PublishedMissionController create() => PublishedMissionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PublishedMission? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PublishedMission?>(value),
    );
  }
}

String _$publishedMissionControllerHash() =>
    r'a81c652d0027d1d0dcfdeab444197965216f9c0b';

abstract class _$PublishedMissionController
    extends $Notifier<PublishedMission?> {
  PublishedMission? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PublishedMission?, PublishedMission?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PublishedMission?, PublishedMission?>,
              PublishedMission?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
