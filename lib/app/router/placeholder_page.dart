import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';

/// Lien affiché sous l'état vide d'une page d'onglet pas encore construite.
class PlaceholderLink {
  const PlaceholderLink({required this.label, required this.path});

  final String label;
  final String path;
}

/// Page d'onglet en attendant sa feature : titre, état vide. L'en-tête
/// (bascule + cloche) est porté par [RoleShell], pas par cette page.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    super.key,
    required this.title,
    this.links = const [],
  });

  final String title;
  final List<PlaceholderLink> links;

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
        for (final link in links) ...[
          const SizedBox(height: AppSpacing.sm),
          AppListTile(title: link.label, onTap: () => context.push(link.path)),
        ],
      ],
    );
  }
}
