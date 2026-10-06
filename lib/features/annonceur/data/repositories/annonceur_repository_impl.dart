import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/annonceur/data/datasources/annonceur_remote_data_source.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/wallet.dart';
import 'package:micro_opportunites/features/annonceur/domain/repositories/annonceur_repository.dart';

class AnnonceurRepositoryImpl implements AnnonceurRepository {
  AnnonceurRepositoryImpl(this._remote);

  final AnnonceurRemoteDataSource _remote;

  @override
  Future<Result<List<MissionSummary>>> fetchMyMissions() => guardResult(
    () async => [for (final m in await _remote.fetchMyMissions()) m.toEntity()],
  );

  @override
  Future<Result<MissionSummary>> fetchMission(String id) =>
      guardResult(() async => (await _remote.fetchMission(id)).toEntity());

  @override
  Future<Result<MissionSummary>> publish(MissionDraft draft) =>
      guardResult(() async => (await _remote.publish(draft)).toEntity());

  @override
  Future<Result<List<Candidate>>> fetchCandidates(String missionId) =>
      guardResult(
        () async => [
          for (final c in await _remote.fetchCandidates(missionId))
            c.toEntity(),
        ],
      );

  @override
  Future<Result<Candidate>> retain(String applicationId) =>
      guardResult(() async => (await _remote.offer(applicationId)).toEntity());

  @override
  Future<Result<Candidate>> reject(String applicationId) =>
      guardResult(() async => (await _remote.reject(applicationId)).toEntity());

  @override
  Future<Result<Candidate>> validate(String assignmentId) => guardResult(
    () async => (await _remote.validate(assignmentId)).toEntity(),
  );

  @override
  Future<Result<Candidate>> contest(String assignmentId, String reason) =>
      guardResult(
        () async => (await _remote.contest(assignmentId, reason)).toEntity(),
      );

  @override
  Future<Result<MissionSummary>> cancel(String missionId) =>
      guardResult(() async => (await _remote.cancel(missionId)).toEntity());

  @override
  Future<Result<Wallet>> fetchWallet() =>
      guardResult(() async => (await _remote.fetchWallet()).toEntity());
}
