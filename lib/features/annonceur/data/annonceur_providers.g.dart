// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonceur_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(annonceurRepository)
final annonceurRepositoryProvider = AnnonceurRepositoryProvider._();

final class AnnonceurRepositoryProvider
    extends
        $FunctionalProvider<
          AnnonceurRepository,
          AnnonceurRepository,
          AnnonceurRepository
        >
    with $Provider<AnnonceurRepository> {
  AnnonceurRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annonceurRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annonceurRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnnonceurRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnnonceurRepository create(Ref ref) {
    return annonceurRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnnonceurRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnnonceurRepository>(value),
    );
  }
}

String _$annonceurRepositoryHash() =>
    r'306d57572728ec5e881ef1dbfc4f8f6321e6da27';
