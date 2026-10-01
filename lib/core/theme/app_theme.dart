import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_palette.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:google_fonts/google_fonts.dart';

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
  static const Color primaryGreen = Color(0xFF1E5B49);
  static const Color backgroundBeige = Color(0xFFF7F4EF);
  static const Color accentGold = Color(0xFFC78B45);
  static const Color textBlack = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: backgroundBeige,
      primaryColor: primaryGreen,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: accentGold,
        surface: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lora(
          color: textBlack,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.lora(
          color: textBlack,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.lora(
          color: primaryGreen,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.inter(color: textBlack, fontSize: 16),
        bodyMedium: GoogleFonts.inter(color: textGrey, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
      ),
    );
  }
}

