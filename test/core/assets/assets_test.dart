import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/assets/app_images.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('chaque icône est embarquée', () async {
    for (final icon in AppIcons.values) {
      final data = await rootBundle.load(icon.path);
      expect(data.lengthInBytes, greaterThan(0), reason: icon.path);
    }
  });

  test('chaque image est embarquée', () async {
    for (final path in AppImages.all) {
      final data = await rootBundle.load(path);
      expect(data.lengthInBytes, greaterThan(0), reason: path);
    }
  });

  test('les polices et leurs licences sont embarquées', () async {
    const files = [
      'assets/fonts/Fraunces-SemiBold.ttf',
      'assets/fonts/Fraunces-Bold.ttf',
      'assets/fonts/PublicSans-Regular.ttf',
      'assets/fonts/PublicSans-Medium.ttf',
      'assets/fonts/PublicSans-SemiBold.ttf',
      'assets/fonts/PublicSans-Bold.ttf',
      'assets/fonts/IBMPlexMono-Regular.ttf',
      'assets/fonts/IBMPlexMono-Medium.ttf',
      'assets/fonts/licenses/fraunces-OFL.txt',
      'assets/fonts/licenses/publicsans-OFL.txt',
      'assets/fonts/licenses/ibmplexmono-OFL.txt',
    ];
    for (final path in files) {
      final data = await rootBundle.load(path);
      expect(data.lengthInBytes, greaterThan(0), reason: path);
    }
  });
}
