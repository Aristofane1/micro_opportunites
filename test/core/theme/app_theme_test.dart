import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/assets/app_fonts.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_palette.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_theme.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

void main() {
  final theme = AppTheme.light;

  test('couleurs principales du design', () {
    expect(theme.colorScheme.primary, AppColors.green);
    expect(theme.colorScheme.secondary, AppColors.ochreDeep);
    expect(theme.colorScheme.tertiary, AppColors.blue);
    expect(theme.colorScheme.error, AppColors.red);
    expect(theme.colorScheme.surface, AppColors.card);
    expect(theme.colorScheme.onSurface, AppColors.ink);
    expect(theme.scaffoldBackgroundColor, AppColors.ivory);
  });

  test('typographie Lora + Inter', () {
    expect(AppFonts.display, 'Lora');
    expect(AppFonts.body, 'Inter');
  });

  test('typographie : titres en display, texte en body', () {
    expect(theme.textTheme.headlineMedium!.fontFamily, AppFonts.display);
    expect(theme.textTheme.headlineMedium!.fontSize, 28);
    expect(theme.textTheme.bodyMedium!.fontFamily, AppFonts.body);
    expect(theme.textTheme.bodyMedium!.fontSize, 15);
    expect(theme.textTheme.bodySmall!.color, AppColors.inkSecondary);
    expect(AppTypography.reference.fontFamily, AppFonts.mono);
    expect(AppTypography.amount.color, AppColors.green);
  });

  test('palette étendue disponible', () {
    final palette = theme.extension<AppPalette>();
    expect(palette, isNotNull);
    expect(palette!.worker, AppColors.green);
    expect(palette.poster, AppColors.ochreDeep);
  });

  test('boutons de 52 px, cartes sans élévation', () {
    final minimum = theme.filledButtonTheme.style!.minimumSize!.resolve({});
    expect(minimum!.height, AppSizes.buttonHeight);
    expect(theme.cardTheme.elevation, 0);
  });

  test('lerp de la palette conserve les couleurs', () {
    final lerped = AppPalette.light.lerp(AppPalette.light, 0.5);
    expect(lerped.worker, AppColors.green);
    expect(
      AppPalette.light.copyWith(worker: AppColors.blue).worker,
      AppColors.blue,
    );
  });

  testWidgets('context.palette lit l’extension du thème', (tester) async {
    late AppPalette palette;
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Builder(
          builder: (context) {
            palette = context.palette;
            return const SizedBox();
          },
        ),
      ),
    );
    expect(palette.poster, AppColors.ochreDeep);
  });
}
