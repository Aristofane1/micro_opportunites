import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/backend/config_error_app.dart';
import 'package:micro_opportunites/app/backend/supabase_config.dart';
import 'package:micro_opportunites/app/bootstrap.dart';
import 'package:micro_opportunites/core/assets/font_licenses.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerFontLicenses();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final keys = readSupabaseKeys();
  if (keys == null) {
    runApp(const ConfigErrorApp());
    return;
  }
  final client = await initSupabase(keys);
  runApp(
    ProviderScope(
      overrides: [...appOverrides(), ...supabaseOverrides(client)],
      // Pas de nouvelle tentative automatique : l'écran propose « Réessayer ».
      retry: (_, _) => null,
      child: const App(),
    ),
  );
}
