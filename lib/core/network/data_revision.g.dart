// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_revision.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Compteur incrémenté après chaque écriture réussie (postuler, confirmer,
/// check-in…). Les providers de lecture le surveillent pour se recharger,
/// sans qu'une feature ait à connaître les providers d'une autre.

@ProviderFor(DataRevision)
final dataRevisionProvider = DataRevisionProvider._();

/// Compteur incrémenté après chaque écriture réussie (postuler, confirmer,
/// check-in…). Les providers de lecture le surveillent pour se recharger,
/// sans qu'une feature ait à connaître les providers d'une autre.
final class DataRevisionProvider extends $NotifierProvider<DataRevision, int> {
  /// Compteur incrémenté après chaque écriture réussie (postuler, confirmer,
  /// check-in…). Les providers de lecture le surveillent pour se recharger,
  /// sans qu'une feature ait à connaître les providers d'une autre.
  DataRevisionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataRevisionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataRevisionHash();

  @$internal
  @override
  DataRevision create() => DataRevision();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$dataRevisionHash() => r'ca037e5b229ceeefae691f4c00320644b0d8410e';

/// Compteur incrémenté après chaque écriture réussie (postuler, confirmer,
/// check-in…). Les providers de lecture le surveillent pour se recharger,
/// sans qu'une feature ait à connaître les providers d'une autre.

abstract class _$DataRevision extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
