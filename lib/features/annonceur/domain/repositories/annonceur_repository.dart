import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/wallet.dart';

abstract interface class AnnonceurRepository {
  Future<Result<List<MissionSummary>>> fetchMyMissions();

  Future<Result<MissionSummary>> fetchMission(String id);

  Future<Result<MissionSummary>> publish(MissionDraft draft);

  Future<Result<List<Candidate>>> fetchCandidates(String missionId);

  Future<Result<Candidate>> retain(String applicationId);

  Future<Result<Candidate>> reject(String applicationId);

  Future<Result<Candidate>> validate(String assignmentId);

  Future<Result<Candidate>> contest(String assignmentId, String reason);

  Future<Result<MissionSummary>> cancel(String missionId);

  Future<Result<Wallet>> fetchWallet();
}
