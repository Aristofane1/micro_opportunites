// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_draft_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MissionDraftController)
final missionDraftControllerProvider = MissionDraftControllerProvider._();

final class MissionDraftControllerProvider
    extends $NotifierProvider<MissionDraftController, MissionDraft> {
  MissionDraftControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'missionDraftControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$missionDraftControllerHash();

  @$internal
  @override
  MissionDraftController create() => MissionDraftController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MissionDraft value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MissionDraft>(value),
    );
  }
}

String _$missionDraftControllerHash() =>
    r'be804f475709b88cba2cab855c363226fb0911d6';

abstract class _$MissionDraftController extends $Notifier<MissionDraft> {
  MissionDraft build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MissionDraft, MissionDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MissionDraft, MissionDraft>,
              MissionDraft,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
