/// Chemins du module C (annonceur). Les features naviguent avec ces
/// constantes sans importer `app/`.
abstract final class PosterPaths {
  static const missions = '/poster/missions';
  static const publish = '/poster/publish';
  static const payments = '/poster/payments';
  static const messages = '/poster/messages';
  static const profile = '/poster/me';
  static const publishNew = '/poster/publish/new';
  static const publishDone = '/poster/publish/done';

  static String missionManage(String id) => '/poster/missions/manage/$id';
  static String candidates(String id) => '${missionManage(id)}/candidates';
  static String candidate(String id, String candidateId) =>
      '${missionManage(id)}/candidate/$candidateId';
  static String today(String id) => '${missionManage(id)}/today';
  static String validate(String id, String assignmentId) =>
      '${missionManage(id)}/validate/$assignmentId';
  static String contest(String id, String assignmentId) =>
      '${missionManage(id)}/contest/$assignmentId';
  static String cancel(String id) => '${missionManage(id)}/cancel';
}
