import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

/// Point unique de choix du client API. Surchargé au démarrage par
/// `main.dart` (Supabase) ou par les tests (faux serveur).
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  throw UnimplementedError(
    'apiClientProvider doit être surchargé au démarrage (main.dart).',
  );
}
