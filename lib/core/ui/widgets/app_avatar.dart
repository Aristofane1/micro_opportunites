import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

/// Avatar à initiales sur teinte verte douce.
class AppAvatar extends StatelessWidget {
  const AppAvatar({super.key, required this.name, this.size = 40});

  final String name;
  final double size;

  static String initialsOf(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    return parts
        .take(2)
        .map((part) => part.characters.first.toUpperCase())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: name,
      image: true,
      child: ExcludeSemantics(
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.softGreen,
            shape: BoxShape.circle,
          ),
          child: Text(
            initialsOf(name),
            style: AppTypography.bodyStrong.copyWith(
              color: AppColors.green,
              fontSize: size * 0.36,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
