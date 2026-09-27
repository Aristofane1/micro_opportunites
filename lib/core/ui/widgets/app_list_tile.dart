import 'package:flutter/material.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';

/// Ligne de liste (planche Z3) : carte bordée, arrondi 12, chevron.
class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
    this.showChevron = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        button: onTap != null,
        child: Material(
          color: AppColors.card,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.tileAll,
            side: BorderSide(color: AppColors.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  if (leading != null) ...[leading!, const SizedBox(width: 12)],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTypography.bodyStrong),
                        if (subtitle != null)
                          Text(subtitle!, style: AppTypography.caption),
                      ],
                    ),
                  ),
                  if (showChevron && onTap != null)
                    const AppIcon(
                      AppIcons.forward,
                      size: 20,
                      color: AppColors.inkSecondary,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
