// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Point unique de choix du client API. Surchargé au démarrage par
/// `app/bootstrap.dart` (faux serveur aujourd'hui, HTTP demain).

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

/// Point unique de choix du client API. Surchargé au démarrage par
/// `app/bootstrap.dart` (faux serveur aujourd'hui, HTTP demain).

final class ApiClientProvider
    extends $FunctionalProvider<ApiClient, ApiClient, ApiClient>
    with $Provider<ApiClient> {
  /// Point unique de choix du client API. Surchargé au démarrage par
  /// `app/bootstrap.dart` (faux serveur aujourd'hui, HTTP demain).
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiClient create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiClient>(value),
    );
  }
}

String _$apiClientHash() => r'12a2a1bac64b02c9ad28c304367bd1e501082c5e';
