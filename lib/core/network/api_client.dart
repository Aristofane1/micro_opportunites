/// Port d'accès à l'API. Renvoie du JSON décodé (`Map<String, dynamic>`,
/// `List<dynamic>` ou `null`) et lève [ApiException] en cas d'échec.
///
/// Aujourd'hui : `FakeApiClient` (lib/dev/fake_api). Demain : un client
/// HTTP qui implémente la même interface — rien d'autre ne change.
abstract interface class ApiClient {
  Future<Object?> get(String path, {Map<String, String>? query});

  Future<Object?> post(String path, {Object? body});

  Future<Object?> delete(String path);
}
