/// Port d'accès à l'API. Renvoie du JSON décodé (`Map<String, dynamic>`,
/// `List<dynamic>` ou `null`) et lève [ApiException] en cas d'échec.
///
/// Implémentations : l'adaptateur Supabase (`app/backend`) et, pour
/// les tests seulement, `FakeApiClient` (`test/support/fake_backend`).
abstract interface class ApiClient {
  Future<Object?> get(String path, {Map<String, String>? query});

  Future<Object?> post(String path, {Object? body});

  Future<Object?> delete(String path);
}
