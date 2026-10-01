import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

/// Apparences de statut de la planche Z3 (« même forme partout,
/// couleur + libellé »). Les enums métier des features se mappent dessus.
enum MissionStatusKind {
  draft('Brouillon', AppColors.disabledBackground, AppColors.neutralForeground),
  awaitingPayment('Attente paiement', AppColors.softOchre, AppColors.ochreDeep),
  published('Publiée', AppColors.softGreen, AppColors.green),
  pending('En attente', AppColors.pendingBackground, AppColors.ochreDeep),
  confirmed('Confirmée', AppColors.green, AppColors.white),
  inProgress('En cours', AppColors.softBlue, AppColors.blue),
  toValidate('À valider', AppColors.blue, AppColors.white),
  completedPaid('Terminée · payée', AppColors.ink, AppColors.ivory),
  cancelled(
    'Annulée',
    AppColors.disabledBackground,
    AppColors.neutralForeground,
  ),
  expired('Expirée', AppColors.disabledBackground, AppColors.neutralForeground),
  disputed('En litige', AppColors.softRed, AppColors.red),
  pendingSync(
    "En attente d'envoi",
    AppColors.disabledBackground,
    AppColors.neutralForeground,
  );

  const MissionStatusKind(this.label, this.background, this.foreground);

  final String label;
  final Color background;
  final Color foreground;
}

/// Badge de statut de la planche Z3. À placer dans un `Flexible` (ou
/// `Expanded`) quand il partage une `Row` avec un autre élément : le
/// libellé se tronque plutôt que de déborder.
class StatusBadge extends StatelessWidget {
  const StatusBadge(this.kind, {super.key, this.label});

  final MissionStatusKind kind;

  /// Libellé affiché à la place de `kind.label` (ex. « Retirée »).
  final String? label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: kind.background,
        borderRadius: AppRadius.pillAll,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        child: Text(
          label ?? kind.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.small.copyWith(
            color: kind.foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
