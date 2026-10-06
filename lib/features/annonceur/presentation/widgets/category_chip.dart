import 'package:flutter/material.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

/// Catégories proposées dans le formulaire, dans l'ordre de la maquette.
const publishableCategories = <MissionCategory>[
  MissionCategory.delivery,
  MissionCategory.shopping,
  MissionCategory.computer,
  MissionCategory.dataEntry,
  MissionCategory.cleaning,
  MissionCategory.event,
  MissionCategory.repair,
  MissionCategory.other,
];

/// Affichage propre à l'écran de publication (on ne modifie pas l'enum de l'équipe).
extension MissionCategoryUi on MissionCategory {
  // La maquette écrit « Saisie », le label complet serait trop long pour la case
  String get shortLabel => switch (this) {
    MissionCategory.dataEntry => 'Saisie',
    _ => label,
  };

  IconData get icon => switch (this) {
    MissionCategory.delivery => Icons.local_shipping_outlined,
    MissionCategory.shopping => Icons.shopping_bag_outlined,
    MissionCategory.computer => Icons.laptop_outlined,
    MissionCategory.dataEntry => Icons.article_outlined,
    MissionCategory.cleaning => Icons.cleaning_services_outlined,
    MissionCategory.event => Icons.home_outlined,
    MissionCategory.repair => Icons.build_outlined,
    MissionCategory.flyers => Icons.campaign_outlined,
    MissionCategory.other => Icons.more_horiz,
  };
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final MissionCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected ? colors.primaryContainer : null,
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, color: selected ? colors.primary : null),
            const SizedBox(height: 4),
            Text(
              category.shortLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
