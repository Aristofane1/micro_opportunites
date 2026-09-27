import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Déclare les licences OFL des polices embarquées (écran « Licences »).
void registerFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    const fonts = [
      ('Fraunces', 'fraunces'),
      ('Public Sans', 'publicsans'),
      ('IBM Plex Mono', 'ibmplexmono'),
    ];
    for (final (family, slug) in fonts) {
      final text = await rootBundle.loadString(
        'assets/fonts/licenses/$slug-OFL.txt',
      );
      yield LicenseEntryWithLineBreaks([family], text);
    }
  });
}
