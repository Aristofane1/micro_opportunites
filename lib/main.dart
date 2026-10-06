import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/bootstrap.dart';
import 'package:micro_opportunites/core/assets/font_licenses.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/dev/dev_start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerFontLicenses();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      overrides: [
        ...appOverrides(),
        if (startOnPublish)
          initialLocationProvider.overrideWithValue(AppRoutes.posterPublishNew),
      ],
      // Pas de nouvelle tentative automatique : l'écran propose « Réessayer ».
      retry: (_, _) => null,
      child: const App(),
    ),
  );
}
