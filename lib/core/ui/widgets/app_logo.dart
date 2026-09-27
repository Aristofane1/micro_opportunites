import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:micro_opportunites/core/assets/app_fonts.dart';
import 'package:micro_opportunites/core/assets/app_images.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

enum AppLogoVariant {
  /// Icône seule.
  mark,

  /// Icône + « MicroOpportunités ».
  horizontal,

  /// Icône + « MicroOp » (espaces étroits).
  short,

  /// Épingle + nom en crème, empilés, pour fond vert Calavi.
  stackedInverse,
}

/// Logo de la marque. [size] est la hauteur de l'icône ; sous 48 px la
/// flèche de la pièce disparaît (planche Z1).
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.variant = AppLogoVariant.horizontal,
    this.size = 48,
  });

  static const semanticLabel = 'MicroOpportunités';
  static const _smallThreshold = 48.0;

  final AppLogoVariant variant;
  final double size;

  @override
  Widget build(BuildContext context) {
    final content = switch (variant) {
      AppLogoVariant.mark => _mark(),
      AppLogoVariant.horizontal => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _mark(),
          SizedBox(width: size * 0.2),
          Flexible(
            child: _Wordmark(suffix: 'Opportunités', fontSize: size * 0.375),
          ),
        ],
      ),
      AppLogoVariant.short => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _mark(),
          SizedBox(width: size * 0.25),
          Flexible(
            child: _Wordmark(suffix: 'Op', fontSize: size * 0.7),
          ),
        ],
      ),
      AppLogoVariant.stackedInverse => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppImages.logoPin, width: size, height: size),
          SizedBox(height: size * 0.19),
          _Wordmark(
            suffix: 'Opportunités',
            fontSize: size * 0.35,
            inverse: true,
          ),
        ],
      ),
    };
    return Semantics(
      label: semanticLabel,
      image: true,
      child: ExcludeSemantics(child: content),
    );
  }

  Widget _mark() {
    return SvgPicture.asset(
      size < _smallThreshold ? AppImages.logoMarkSmall : AppImages.logoMark,
      width: size,
      height: size,
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({
    required this.suffix,
    required this.fontSize,
    this.inverse = false,
  });

  final String suffix;
  final double fontSize;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Micro',
            style: TextStyle(
              color: inverse ? AppColors.cream : AppColors.green,
            ),
          ),
          TextSpan(
            text: suffix,
            style: TextStyle(color: inverse ? AppColors.cream : AppColors.ink),
          ),
        ],
      ),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: AppFonts.display,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        height: 1,
        letterSpacing: -0.01 * fontSize,
      ),
    );
  }
}
