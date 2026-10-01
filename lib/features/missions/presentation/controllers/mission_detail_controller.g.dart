// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(missionDetail)
final missionDetailProvider = MissionDetailFamily._();

final class MissionDetailProvider
    extends $FunctionalProvider<AsyncValue<Mission>, Mission, FutureOr<Mission>>
    with $FutureModifier<Mission>, $FutureProvider<Mission> {
  MissionDetailProvider._({
    required MissionDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'missionDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$missionDetailHash();

  @override
  String toString() {
    return r'missionDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Mission> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Mission> create(Ref ref) {
    final argument = this.argument as String;
    return missionDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MissionDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$missionDetailHash() => r'6f550ee88dfbf3c97f6ab0453f72cedc0b10f574';

final class MissionDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Mission>, String> {
  MissionDetailFamily._()
    : super(
        retry: null,
        name: r'missionDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MissionDetailProvider call(String id) =>
      MissionDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'missionDetailProvider';
}

@ProviderFor(posterProfile)
final posterProfileProvider = PosterProfileFamily._();

final class PosterProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<PosterProfile>,
          PosterProfile,
          FutureOr<PosterProfile>
        >
    with $FutureModifier<PosterProfile>, $FutureProvider<PosterProfile> {
  PosterProfileProvider._({
    required PosterProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'posterProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$posterProfileHash();

  @override
  String toString() {
    return r'posterProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PosterProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PosterProfile> create(Ref ref) {
    final argument = this.argument as String;
    return posterProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PosterProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$posterProfileHash() => r'0f7ee93786e366844d159132bf7d23b79800eb3b';

final class PosterProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PosterProfile>, String> {
  PosterProfileFamily._()
    : super(
        retry: null,
        name: r'posterProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PosterProfileProvider call(String id) =>
      PosterProfileProvider._(argument: id, from: this);

  @override
  String toString() => r'posterProfileProvider';
}
