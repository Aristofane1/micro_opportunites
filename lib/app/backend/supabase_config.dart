import 'package:flutter_riverpod/misc.dart';
import 'package:micro_opportunites/app/backend/supabase_api_client.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Adresse du projet et clé publique (anon). Jamais la clé service_role.
typedef SupabaseKeys = ({String url, String anonKey});

/// Clés passées au build (`--dart-define-from-file=env/dev.json`), ou `null`
/// si l'une manque.
SupabaseKeys? readSupabaseKeys() {
  const url = String.fromEnvironment('SUPABASE_URL');
  const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  if (url.isEmpty || anonKey.isEmpty) return null;
  return (url: url, anonKey: anonKey);
}

/// Initialise Supabase ; la session est conservée d'un lancement à l'autre.
Future<SupabaseClient> initSupabase(SupabaseKeys keys) async {
  final supabase = await Supabase.initialize(
    url: keys.url,
    publishableKey: keys.anonKey,
  );
  return supabase.client;
}

/// Branche Supabase comme fournisseur de données de l'app.
List<Override> supabaseOverrides(SupabaseClient client) => [
  apiClientProvider.overrideWithValue(SupabaseApiClient(client)),
];
