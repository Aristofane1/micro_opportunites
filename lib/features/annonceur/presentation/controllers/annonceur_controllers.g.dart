// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonceur_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myMissions)
final myMissionsProvider = MyMissionsProvider._();

final class MyMissionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MissionSummary>>,
          List<MissionSummary>,
          FutureOr<List<MissionSummary>>
        >
    with
        $FutureModifier<List<MissionSummary>>,
        $FutureProvider<List<MissionSummary>> {
  MyMissionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myMissionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myMissionsHash();

  @$internal
  @override
  $FutureProviderElement<List<MissionSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MissionSummary>> create(Ref ref) {
    return myMissions(ref);
  }
}

String _$myMissionsHash() => r'dbb6ecdfe2ce146644e91d9371dc007d136b2b0b';

@ProviderFor(posterMission)
final posterMissionProvider = PosterMissionFamily._();

final class PosterMissionProvider
    extends
        $FunctionalProvider<
          AsyncValue<MissionSummary>,
          MissionSummary,
          FutureOr<MissionSummary>
        >
    with $FutureModifier<MissionSummary>, $FutureProvider<MissionSummary> {
  PosterMissionProvider._({
    required PosterMissionFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'posterMissionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$posterMissionHash();

  @override
  String toString() {
    return r'posterMissionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MissionSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MissionSummary> create(Ref ref) {
    final argument = this.argument as String;
    return posterMission(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PosterMissionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$posterMissionHash() => r'053c2cf60c3f48996f174d2e2b6a611fc99807d0';

final class PosterMissionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MissionSummary>, String> {
  PosterMissionFamily._()
    : super(
        retry: null,
        name: r'posterMissionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PosterMissionProvider call(String id) =>
      PosterMissionProvider._(argument: id, from: this);

  @override
  String toString() => r'posterMissionProvider';
}

@ProviderFor(missionCandidates)
final missionCandidatesProvider = MissionCandidatesFamily._();

final class MissionCandidatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Candidate>>,
          List<Candidate>,
          FutureOr<List<Candidate>>
        >
    with $FutureModifier<List<Candidate>>, $FutureProvider<List<Candidate>> {
  MissionCandidatesProvider._({
    required MissionCandidatesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'missionCandidatesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$missionCandidatesHash();

  @override
  String toString() {
    return r'missionCandidatesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Candidate>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Candidate>> create(Ref ref) {
    final argument = this.argument as String;
    return missionCandidates(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MissionCandidatesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$missionCandidatesHash() => r'c08e79424f7689d96f59b92f32d35257a1ed92b4';

final class MissionCandidatesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Candidate>>, String> {
  MissionCandidatesFamily._()
    : super(
        retry: null,
        name: r'missionCandidatesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MissionCandidatesProvider call(String missionId) =>
      MissionCandidatesProvider._(argument: missionId, from: this);

  @override
  String toString() => r'missionCandidatesProvider';
}

/// Candidats ayant signalé la fin, sur toutes mes missions en cours.

@ProviderFor(pendingValidations)
final pendingValidationsProvider = PendingValidationsProvider._();

/// Candidats ayant signalé la fin, sur toutes mes missions en cours.

final class PendingValidationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PendingValidation>>,
          List<PendingValidation>,
          FutureOr<List<PendingValidation>>
        >
    with
        $FutureModifier<List<PendingValidation>>,
        $FutureProvider<List<PendingValidation>> {
  /// Candidats ayant signalé la fin, sur toutes mes missions en cours.
  PendingValidationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingValidationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingValidationsHash();

  @$internal
  @override
  $FutureProviderElement<List<PendingValidation>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PendingValidation>> create(Ref ref) {
    return pendingValidations(ref);
  }
}

String _$pendingValidationsHash() =>
    r'3cc6c609db5d1949962e4bc378e0e148425a20f4';

@ProviderFor(wallet)
final walletProvider = WalletProvider._();

final class WalletProvider
    extends $FunctionalProvider<AsyncValue<Wallet>, Wallet, FutureOr<Wallet>>
    with $FutureModifier<Wallet>, $FutureProvider<Wallet> {
  WalletProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletHash();

  @$internal
  @override
  $FutureProviderElement<Wallet> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Wallet> create(Ref ref) {
    return wallet(ref);
  }
}

String _$walletHash() => r'8aacf389951257819863c420d7908d521deb3c55';

/// Dernière mission publiée (écran « Votre mission est en ligne »).

@ProviderFor(LastPublished)
final lastPublishedProvider = LastPublishedProvider._();

/// Dernière mission publiée (écran « Votre mission est en ligne »).
final class LastPublishedProvider
    extends $NotifierProvider<LastPublished, MissionSummary?> {
  /// Dernière mission publiée (écran « Votre mission est en ligne »).
  LastPublishedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastPublishedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastPublishedHash();

  @$internal
  @override
  LastPublished create() => LastPublished();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MissionSummary? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MissionSummary?>(value),
    );
  }
}

String _$lastPublishedHash() => r'7f7c5c772f8ae4b801a77f434c9cd98051939a5f';

/// Dernière mission publiée (écran « Votre mission est en ligne »).

abstract class _$LastPublished extends $Notifier<MissionSummary?> {
  MissionSummary? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MissionSummary?, MissionSummary?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MissionSummary?, MissionSummary?>,
              MissionSummary?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Actions d'écriture de l'annonceur. L'état indique si une action est en
/// cours ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.

@ProviderFor(AnnonceurActions)
final annonceurActionsProvider = AnnonceurActionsProvider._();

/// Actions d'écriture de l'annonceur. L'état indique si une action est en
/// cours ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
final class AnnonceurActionsProvider
    extends $AsyncNotifierProvider<AnnonceurActions, void> {
  /// Actions d'écriture de l'annonceur. L'état indique si une action est en
  /// cours ; chaque succès incrémente `dataRevisionProvider`.
  /// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
  AnnonceurActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'annonceurActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$annonceurActionsHash();

  @$internal
  @override
  AnnonceurActions create() => AnnonceurActions();
}

String _$annonceurActionsHash() => r'c6b7f2d289f57a9ed74fefe5cecc9a059def4065';

/// Actions d'écriture de l'annonceur. L'état indique si une action est en
/// cours ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.

abstract class _$AnnonceurActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
