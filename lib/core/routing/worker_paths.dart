/// Chemins du module B (exécutant). Les features naviguent avec ces
/// constantes sans importer `app/`.
abstract final class WorkerPaths {
  static const explore = '/worker/explore';
  static const exploreMap = '/worker/explore/map';
  static const applications = '/worker/applications';
  static const earnings = '/worker/earnings';
  static const messages = '/worker/messages';
  static const profile = '/worker/me';

  static String exploreSearch(String query) => Uri(
    path: '/worker/explore/search',
    queryParameters: {'q': query},
  ).toString();
  static String missionDetail(String missionId) =>
      '/worker/missions/$missionId';
  static String apply(String missionId) => '/worker/missions/$missionId/apply';
  static String applicationSent(String posterName) => Uri(
    path: '/worker/applications/sent',
    queryParameters: {'poster': posterName},
  ).toString();
  static String offer(String applicationId) =>
      '/worker/applications/$applicationId/offer';
  static String poster(String posterId) => '/worker/posters/$posterId';
  static String assignment(String assignmentId) =>
      '/worker/assignments/$assignmentId';
  static String reportEnd(String assignmentId) =>
      '/worker/assignments/$assignmentId/report-end';
  static String payout(String payoutId) => '/worker/payouts/$payoutId';
  static String alerts({String? keyword}) => keyword == null
      ? '/worker/alerts'
      : Uri(path: '/worker/alerts', queryParameters: {'q': keyword}).toString();
}
