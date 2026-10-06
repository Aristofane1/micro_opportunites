import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';

abstract final class AppRoutes {
  /// Splash : début du parcours d'entrée.
  static const root = '/';

  static const workerExplore = WorkerPaths.explore;
  static const workerApplications = WorkerPaths.applications;
  static const workerEarnings = WorkerPaths.earnings;
  static const workerMessages = WorkerPaths.messages;
  static const workerProfile = WorkerPaths.profile;

  static const posterMissions = PosterPaths.missions;
  static const posterPublish = PosterPaths.publish;
  static const posterPayments = PosterPaths.payments;
  static const posterMessages = PosterPaths.messages;
  static const posterProfile = PosterPaths.profile;
  static const posterPublishNew = PosterPaths.publishNew;
  static const posterPublishConfirm = '/poster/publish/confirm';
  static const posterPublishDone = PosterPaths.publishDone;
  static String posterMissionManage(String id) => PosterPaths.missionManage(id);
  static String posterCandidates(String id) => PosterPaths.candidates(id);
  static String posterCandidate(String id, String candidateId) =>
      PosterPaths.candidate(id, candidateId);
  static String posterToday(String id) => PosterPaths.today(id);
  static String posterValidate(String id, String candidateId) =>
      PosterPaths.validate(id, candidateId);

  static String homeFor(ActiveRole role) => switch (role) {
    ActiveRole.worker => workerExplore,
    ActiveRole.poster => posterMissions,
  };

  /// Rôle auquel appartient [location], ou null hors des shells.
  static ActiveRole? roleOf(String location) {
    if (location == '/worker' || location.startsWith('/worker/')) {
      return ActiveRole.worker;
    }
    if (location == '/poster' || location.startsWith('/poster/')) {
      return ActiveRole.poster;
    }
    return null;
  }
}
