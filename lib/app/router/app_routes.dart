import 'package:micro_opportunites/app/role/active_role.dart';

abstract final class AppRoutes {
  static const root = '/';

  static const workerExplore = '/worker/explore';
  static const workerApplications = '/worker/applications';
  static const workerEarnings = '/worker/earnings';
  static const workerMessages = '/worker/messages';
  static const workerProfile = '/worker/me';

  static const posterMissions = '/poster/missions';
  static const posterPublish = '/poster/publish';
  static const posterPayments = '/poster/payments';
  static const posterMessages = '/poster/messages';
  static const posterProfile = '/poster/me';

  static const designSystem = '/design-system';

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
