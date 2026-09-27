import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/assets/app_fonts.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

/// Échelle typographique du design. Les tailles suivent le réglage
/// de taille de texte du téléphone (aucun blocage du textScaler).
abstract final class AppTypography {
  static const hero = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 34,
    height: 1.1,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static const title = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.28,
    color: AppColors.ink,
  );
  static const heading = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static const headingSmall = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static const amount = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 22,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.green,
  );
  static const subtitle = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 17,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static const bodyStrong = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static const body = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
  );
  static const label = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );
  static const caption = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 13,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.inkSecondary,
  );
  static const small = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );
  static const navLabel = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 11,
    height: 1.2,
    fontWeight: FontWeight.w500,
    color: AppColors.inkSecondary,
  );
  static const button = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 16,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );
  static const reference = TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
  );

  static const textTheme = TextTheme(
    displaySmall: hero,
    headlineMedium: title,
    headlineSmall: heading,
    titleLarge: headingSmall,
    titleMedium: subtitle,
    titleSmall: bodyStrong,
    bodyLarge: body,
    bodyMedium: body,
    bodySmall: caption,
    labelLarge: label,
    labelMedium: small,
    labelSmall: navLabel,
  );
}
