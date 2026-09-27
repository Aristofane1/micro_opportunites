import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets(
    'M4 : Review focus : chaque segment garde un visuel 38 px mais une '
    'zone tactile ≥ 44 px',
    (tester) async {
      await tester.pumpThemed(const RoleSwitcher());
      final segment = find
          .ancestor(
            of: find.text('Exécutant'),
            matching: find.byType(GestureDetector),
          )
          .last;
      expect(tester.getSize(segment).height, greaterThanOrEqualTo(44));
    },
  );
}
