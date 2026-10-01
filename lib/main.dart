import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/bootstrap.dart';
import 'package:micro_opportunites/core/assets/font_licenses.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerFontLicenses();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      overrides: appOverrides(),
      // Pas de nouvelle tentative automatique : l'écran propose « Réessayer ».
      retry: (_, _) => null,
      child: const App(),
    ),
  );
}
