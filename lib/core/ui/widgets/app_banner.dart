import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

enum AppBannerTone { success, todo, offline, error }

/// Bandeau d'information (planche Z3 · Bandeaux).
class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.message,
    this.title,
    this.tone = AppBannerTone.success,
  });

  final String message;
  final String? title;
  final AppBannerTone tone;

  @override
  Widget build(BuildContext context) {
    final (background, border, foreground) = switch (tone) {
      AppBannerTone.success => (
        AppColors.softGreen,
        AppColors.green,
        AppColors.bannerGreenText,
      ),
      AppBannerTone.todo => (
        AppColors.softOchre,
        AppColors.bannerOchreBorder,
        AppColors.bannerOchreText,
      ),
      AppBannerTone.offline => (AppColors.ink, AppColors.ink, AppColors.ivory),
      AppBannerTone.error => (
        AppColors.softRed,
        AppColors.red,
        AppColors.bannerRedText,
      ),
    };
    return Semantics(
      liveRegion: tone == AppBannerTone.offline || tone == AppBannerTone.error,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: border),
          borderRadius: AppRadius.tileAll,
        ),
        child: Text.rich(
          TextSpan(
            children: [
              if (title != null)
                TextSpan(
                  text: '$title ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              TextSpan(text: message),
            ],
          ),
          style: AppTypography.caption.copyWith(
            color: foreground,
            height: 1.45,
          ),
        ),
      ),
    );
  }
}
