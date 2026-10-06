// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_missions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyMissionsController)
final myMissionsControllerProvider = MyMissionsControllerProvider._();

final class MyMissionsControllerProvider
    extends $NotifierProvider<MyMissionsController, List<MissionSummary>> {
  MyMissionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myMissionsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myMissionsControllerHash();

  @$internal
  @override
  MyMissionsController create() => MyMissionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MissionSummary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MissionSummary>>(value),
    );
  }
}

String _$myMissionsControllerHash() =>
    r'f6b111119c6e35d1b63b0b99ac95e8b3c95151cf';

abstract class _$MyMissionsController extends $Notifier<List<MissionSummary>> {
  List<MissionSummary> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<MissionSummary>, List<MissionSummary>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<MissionSummary>, List<MissionSummary>>,
              List<MissionSummary>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
