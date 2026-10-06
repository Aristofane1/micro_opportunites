import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/app/app.dart';
import 'package:micro_opportunites/app/bootstrap.dart';
import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/core/assets/font_licenses.dart';
import 'package:micro_opportunites/app/router/app_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/dev/dev_start.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';

/// Rôle annonceur imposé par le raccourci de développement.
class _PosterRole extends ActiveRoleNotifier {
  @override
  ActiveRole build() => ActiveRole.poster;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerFontLicenses();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      overrides: [
        ...appOverrides(),
        if (startOnPublish) ...[
          initialLocationProvider.overrideWithValue(PosterPaths.publishNew),
          activeRoleProvider.overrideWith(() => _PosterRole()),
          annonceurDemoDataProvider.overrideWithValue(true),
        ],
      ],
      // Pas de nouvelle tentative automatique : l'écran propose « Réessayer ».
      retry: (_, _) => null,
      child: const App(),
    ),
  );
}
