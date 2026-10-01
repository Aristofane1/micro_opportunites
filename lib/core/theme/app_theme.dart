import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_palette.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

/// Thème Material 3 clair. Pas d'ombres : des bordures fines ; seule la
/// feuille du bas porte une ombre légère.
abstract final class AppTheme {
  static const _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.green,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.softGreen,
    onPrimaryContainer: AppColors.greenDark,
    secondary: AppColors.ochreDeep,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.softOchre,
    onSecondaryContainer: AppColors.ochreDeep,
    tertiary: AppColors.blue,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.softBlue,
    onTertiaryContainer: AppColors.blue,
    error: AppColors.red,
    onError: AppColors.white,
    errorContainer: AppColors.softRed,
    onErrorContainer: AppColors.bannerRedText,
    surface: AppColors.card,
    onSurface: AppColors.ink,
    onSurfaceVariant: AppColors.inkSecondary,
    surfaceContainerLowest: AppColors.card,
    surfaceContainerLow: AppColors.card,
    surfaceContainer: AppColors.ivory,
    surfaceContainerHigh: AppColors.toggleTrack,
    surfaceContainerHighest: AppColors.disabledBackground,
    outline: AppColors.lineStrong,
    outlineVariant: AppColors.line,
    shadow: AppColors.ink,
    scrim: AppColors.ink,
    inverseSurface: AppColors.ink,
    onInverseSurface: AppColors.ivory,
    inversePrimary: AppColors.ochre,
    surfaceTint: Colors.transparent,
  );

  static OutlineInputBorder _outline(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: AppRadius.fieldAll,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static final ThemeData light = _build();

  static ThemeData _build() {
    const buttonShape = RoundedRectangleBorder(borderRadius: AppRadius.cardAll);
    const buttonMinimumSize = Size(
      AppSizes.minTouchTarget,
      AppSizes.buttonHeight,
    );
    const buttonPadding = EdgeInsets.symmetric(horizontal: AppSpacing.lg);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _colorScheme,
      scaffoldBackgroundColor: AppColors.ivory,
      canvasColor: AppColors.ivory,
      textTheme: AppTypography.textTheme,
      splashFactory: InkRipple.splashFactory,
      extensions: const [AppPalette.light],
      iconTheme: const IconThemeData(color: AppColors.ink, size: 24),
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppTypography.headingSmall,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardAll,
          side: BorderSide(color: AppColors.line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.disabledBackground,
          disabledForegroundColor: AppColors.disabledForeground,
          minimumSize: buttonMinimumSize,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: AppTypography.button,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.green,
          backgroundColor: AppColors.card,
          disabledBackgroundColor: AppColors.disabledBackground,
          disabledForegroundColor: AppColors.disabledForeground,
          minimumSize: buttonMinimumSize,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: AppTypography.button,
          side: const BorderSide(color: AppColors.green),
        ),
      ),
      // Pour les ElevatedButton des écrans d'entrée (branche onboarding).
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.disabledBackground,
          disabledForegroundColor: AppColors.disabledForeground,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: AppTypography.button,
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.green,
          minimumSize: const Size(
            AppSizes.minTouchTarget,
            AppSizes.minTouchTarget,
          ),
          textStyle: AppTypography.label.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        hintStyle: AppTypography.body.copyWith(color: AppColors.inkSecondary),
        errorStyle: AppTypography.caption.copyWith(
          color: AppColors.red,
          fontWeight: FontWeight.w500,
        ),
        errorMaxLines: 3,
        border: _outline(AppColors.lineStrong),
        enabledBorder: _outline(AppColors.lineStrong),
        disabledBorder: _outline(AppColors.line),
        focusedBorder: _outline(AppColors.green, 2),
        errorBorder: _outline(AppColors.red, 2),
        focusedErrorBorder: _outline(AppColors.red, 2),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: AppTypography.body.copyWith(
          color: AppColors.ivory,
          fontSize: 14,
        ),
        actionTextColor: AppColors.ochre,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.cardAll),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.card,
        modalBackgroundColor: AppColors.card,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        modalElevation: 8,
        shadowColor: AppColors.ink.withValues(alpha: 0.16),
        showDragHandle: true,
        dragHandleColor: AppColors.lineStrong,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.sheet),
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.green,
        linearTrackColor: AppColors.lineStrong,
        circularTrackColor: Colors.transparent,
      ),
    );
  }
}
