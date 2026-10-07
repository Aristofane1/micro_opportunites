// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'missions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(missionsRepository)
final missionsRepositoryProvider = MissionsRepositoryProvider._();

final class MissionsRepositoryProvider
    extends
        $FunctionalProvider<
          MissionsRepository,
          MissionsRepository,
          MissionsRepository
        >
    with $Provider<MissionsRepository> {
  MissionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'missionsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$missionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<MissionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MissionsRepository create(Ref ref) {
    return missionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MissionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MissionsRepository>(value),
    );
  }
}

String _$missionsRepositoryHash() =>
    r'18ce01392ccee773e85e0268cd1bac5efb3f93fc';
