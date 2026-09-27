import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

/// Couleurs sémantiques absentes de ColorScheme (rôles, argent, teintes).
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.worker,
    required this.poster,
    required this.money,
    required this.info,
    required this.success,
    required this.danger,
    required this.softGreen,
    required this.softOchre,
    required this.softBlue,
    required this.softRed,
  });

  /// Rôle Exécutant.
  final Color worker;

  /// Rôle Annonceur.
  final Color poster;

  /// Argent, séquestre (aplats).
  final Color money;
  final Color info;
  final Color success;
  final Color danger;
  final Color softGreen;
  final Color softOchre;
  final Color softBlue;
  final Color softRed;

  static const light = AppPalette(
    worker: AppColors.green,
    poster: AppColors.ochreDeep,
    money: AppColors.ochre,
    info: AppColors.blue,
    success: AppColors.green,
    danger: AppColors.red,
    softGreen: AppColors.softGreen,
    softOchre: AppColors.softOchre,
    softBlue: AppColors.softBlue,
    softRed: AppColors.softRed,
  );

  @override
  AppPalette copyWith({
    Color? worker,
    Color? poster,
    Color? money,
    Color? info,
    Color? success,
    Color? danger,
    Color? softGreen,
    Color? softOchre,
    Color? softBlue,
    Color? softRed,
  }) {
    return AppPalette(
      worker: worker ?? this.worker,
      poster: poster ?? this.poster,
      money: money ?? this.money,
      info: info ?? this.info,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      softGreen: softGreen ?? this.softGreen,
      softOchre: softOchre ?? this.softOchre,
      softBlue: softBlue ?? this.softBlue,
      softRed: softRed ?? this.softRed,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      worker: Color.lerp(worker, other.worker, t)!,
      poster: Color.lerp(poster, other.poster, t)!,
      money: Color.lerp(money, other.money, t)!,
      info: Color.lerp(info, other.info, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      softGreen: Color.lerp(softGreen, other.softGreen, t)!,
      softOchre: Color.lerp(softOchre, other.softOchre, t)!,
      softBlue: Color.lerp(softBlue, other.softBlue, t)!,
      softRed: Color.lerp(softRed, other.softRed, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
