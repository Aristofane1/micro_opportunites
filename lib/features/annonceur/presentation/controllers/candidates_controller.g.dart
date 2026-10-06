// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Les candidats de chaque mission : identifiant de mission -> liste.
/// À REMPLACER par Firestore quand Firebase sera branché.

@ProviderFor(CandidatesController)
final candidatesControllerProvider = CandidatesControllerProvider._();

/// Les candidats de chaque mission : identifiant de mission -> liste.
/// À REMPLACER par Firestore quand Firebase sera branché.
final class CandidatesControllerProvider
    extends
        $NotifierProvider<CandidatesController, Map<String, List<Candidate>>> {
  /// Les candidats de chaque mission : identifiant de mission -> liste.
  /// À REMPLACER par Firestore quand Firebase sera branché.
  CandidatesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'candidatesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$candidatesControllerHash();

  @$internal
  @override
  CandidatesController create() => CandidatesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<Candidate>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<Candidate>>>(value),
    );
  }
}

String _$candidatesControllerHash() =>
    r'5a3a8677ce583e848621c1dfe6755c0b6c2de853';

/// Les candidats de chaque mission : identifiant de mission -> liste.
/// À REMPLACER par Firestore quand Firebase sera branché.

abstract class _$CandidatesController
    extends $Notifier<Map<String, List<Candidate>>> {
  Map<String, List<Candidate>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<Map<String, List<Candidate>>, Map<String, List<Candidate>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, List<Candidate>>,
                Map<String, List<Candidate>>
              >,
              Map<String, List<Candidate>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
