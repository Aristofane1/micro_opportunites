import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';

/// Page d'onglet en attendant sa feature : titre, état vide. L'en-tête
/// (bascule + cloche) est porté par [RoleShell], pas par cette page.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    super.key,
    required this.title,
    this.showDesignSystemLink = false,
  });

  final String title;
  final bool showDesignSystemLink;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.xl,
      ),
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.lg),
        const EmptyState(
          title: 'Bientôt disponible',
          message: 'Cet écran sera construit avec sa fonctionnalité.',
        ),
        if (showDesignSystemLink) ...[
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: 'Voir le design system',
            variant: AppButtonVariant.secondary,
            onPressed: () => context.push(AppRoutes.designSystem),
          ),
        ],
      ],
    );
  }
}
