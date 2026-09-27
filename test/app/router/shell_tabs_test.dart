import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/router/shell_tabs.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';

void main() {
  test(
    'I2 : ShellTab expose builder/routes, absents par défaut (PlaceholderPage)',
    () {
      const tab = ShellTab(
        path: '/worker/explore',
        label: 'Explorer',
        icon: AppIcons.explore,
      );
      expect(tab.builder, isNull);
      expect(tab.routes, isEmpty);
    },
  );

  test('I2 : ShellTab accepte un builder et des sous-routes', () {
    final tab = ShellTab(
      path: '/worker/explore',
      label: 'Explorer',
      icon: AppIcons.explore,
      builder: (context) => const SizedBox(),
      routes: const [],
    );
    expect(tab.builder, isNotNull);
    expect(tab.routes, isEmpty);
  });
}
