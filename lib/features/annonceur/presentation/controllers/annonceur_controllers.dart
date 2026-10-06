import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/data_revision.dart';
import 'package:micro_opportunites/features/annonceur/data/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/wallet.dart';
import 'package:micro_opportunites/features/annonceur/domain/repositories/annonceur_repository.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annonceur_controllers.g.dart';

@riverpod
Future<List<MissionSummary>> myMissions(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(annonceurRepositoryProvider).fetchMyMissions())
      .getOrThrow();
}

@riverpod
Future<MissionSummary> posterMission(Ref ref, String id) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(annonceurRepositoryProvider).fetchMission(id))
      .getOrThrow();
}

@riverpod
Future<List<Candidate>> missionCandidates(Ref ref, String missionId) async {
  ref.watch(dataRevisionProvider);
  return (await ref
          .watch(annonceurRepositoryProvider)
          .fetchCandidates(missionId))
      .getOrThrow();
}

/// Un travail terminé, en attente de validation par l'annonceur.
class PendingValidation {
  const PendingValidation({required this.missionId, required this.candidate});

  final String missionId;
  final Candidate candidate;
}

/// Candidats ayant signalé la fin, sur toutes mes missions en cours.
@riverpod
Future<List<PendingValidation>> pendingValidations(Ref ref) async {
  final missions = await ref.watch(myMissionsProvider.future);
  final inProgress = missions
      .where((m) => m.status == MissionStatus.inProgress)
      .toList();
  final candidates = await Future.wait([
    for (final m in inProgress)
      ref.watch(missionCandidatesProvider(m.id).future),
  ]);
  return [
    for (var i = 0; i < inProgress.length; i++)
      for (final c in candidates[i])
        if (c.attendance == AttendanceStatus.finished)
          PendingValidation(missionId: inProgress[i].id, candidate: c),
  ];
}

@riverpod
Future<Wallet> wallet(Ref ref) async {
  ref.watch(dataRevisionProvider);
  return (await ref.watch(annonceurRepositoryProvider).fetchWallet())
      .getOrThrow();
}

/// Dernière mission publiée (écran « Votre mission est en ligne »).
@Riverpod(keepAlive: true)
class LastPublished extends _$LastPublished {
  @override
  MissionSummary? build() => null;

  void set(MissionSummary mission) => state = mission;
}

/// Actions d'écriture de l'annonceur. L'état indique si une action est en
/// cours ; chaque succès incrémente `dataRevisionProvider`.
/// `keepAlive` : sans écouteur, l'état serait libéré avant la fin de l'appel.
@Riverpod(keepAlive: true)
class AnnonceurActions extends _$AnnonceurActions {
  @override
  FutureOr<void> build() {}

  /// Publie le brouillon : l'argent est bloqué, le brouillon repart de zéro.
  Future<Result<MissionSummary>> publish() async {
    final draft = ref.read(missionDraftControllerProvider);
    final result = await _run(() => _repository.publish(draft));
    if (result case Success(:final value) when ref.mounted) {
      ref.read(lastPublishedProvider.notifier).set(value);
      ref.read(missionDraftControllerProvider.notifier).reset();
    }
    return result;
  }

  Future<Result<Candidate>> retain(String applicationId) =>
      _run(() => _repository.retain(applicationId));

  Future<Result<Candidate>> reject(String applicationId) =>
      _run(() => _repository.reject(applicationId));

  Future<Result<Candidate>> validate(String assignmentId) =>
      _run(() => _repository.validate(assignmentId));

  Future<Result<Candidate>> contest(String assignmentId, String reason) =>
      _run(() => _repository.contest(assignmentId, reason));

  Future<Result<MissionSummary>> cancel(String missionId) =>
      _run(() => _repository.cancel(missionId));

  AnnonceurRepository get _repository => ref.read(annonceurRepositoryProvider);

  Future<Result<T>> _run<T>(Future<Result<T>> Function() action) async {
    state = const AsyncLoading();
    final result = await action();
    if (!ref.mounted) return result;
    state = switch (result) {
      Success() => const AsyncData(null),
      Err(:final failure) => AsyncError(failure, StackTrace.current),
    };
    if (result.isSuccess) ref.read(dataRevisionProvider.notifier).bump();
    return result;
  }
}
