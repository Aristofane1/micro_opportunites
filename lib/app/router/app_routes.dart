import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';

abstract final class AppRoutes {
  /// Splash : début du parcours d'entrée.
  static const root = '/';

  static const workerExplore = WorkerPaths.explore;
  static const workerApplications = WorkerPaths.applications;
  static const workerEarnings = WorkerPaths.earnings;
  static const workerMessages = WorkerPaths.messages;
  static const workerProfile = WorkerPaths.profile;

  static const posterMissions = '/poster/missions';
  static const posterPublish = '/poster/publish';
  static const posterPayments = '/poster/payments';
  static const posterMessages = '/poster/messages';
  static const posterProfile = '/poster/me';
  static const posterPublishNew = '/poster/publish/new';
  static const posterPublishConfirm = '/poster/publish/confirm';
  static const posterPublishDone = '/poster/publish/done';
  static String posterMissionManage(String id) => '/poster/missions/manage/$id';
  static String homeFor(ActiveRole role) => switch (role) {
    ActiveRole.worker => workerExplore,
    ActiveRole.poster => posterMissions,
  };
  static String posterProblem(String id, String candidateId) =>
      '${posterValidate(id, candidateId)}/problem';
  static String posterCancel(String id) => '${posterMissionManage(id)}/cancel';
  static String posterCandidates(String id) =>
      '${posterMissionManage(id)}/candidates';
  static String posterCandidate(String id, String candidateId) =>
      '${posterMissionManage(id)}/candidate/$candidateId';
  static String posterToday(String id) => '${posterMissionManage(id)}/today';
  static String posterValidate(String id, String candidateId) =>
      '${posterMissionManage(id)}/validate/$candidateId';

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
