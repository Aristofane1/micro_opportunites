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
      'assets/fonts/Lora-Regular.ttf',
      'assets/fonts/Lora-SemiBold.ttf',
      'assets/fonts/Lora-Bold.ttf',
      'assets/fonts/Inter-Regular.ttf',
      'assets/fonts/Inter-Medium.ttf',
      'assets/fonts/Inter-SemiBold.ttf',
      'assets/fonts/Inter-Bold.ttf',
      'assets/fonts/IBMPlexMono-Regular.ttf',
      'assets/fonts/IBMPlexMono-Medium.ttf',
      'assets/fonts/licenses/lora-OFL.txt',
      'assets/fonts/licenses/inter-OFL.txt',
      'assets/fonts/licenses/ibmplexmono-OFL.txt',
    ];
    for (final path in files) {
      final data = await rootBundle.load(path);
      expect(data.lengthInBytes, greaterThan(0), reason: path);
    }
  });
}
