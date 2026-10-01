import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/core/routing/worker_paths.dart';

abstract final class AppRoutes {
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
