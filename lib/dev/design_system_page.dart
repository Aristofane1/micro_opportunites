import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:micro_opportunites/app/role/role_switcher.dart';
import 'package:micro_opportunites/app/router/shell_tabs.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/assets/app_images.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';
import 'package:micro_opportunites/core/theme/app_spacing.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/core/ui/widgets/app_avatar.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/app_logo.dart';
import 'package:micro_opportunites/core/ui/widgets/app_navigation_bar.dart';
import 'package:micro_opportunites/core/ui/widgets/app_text_field.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/core/ui/widgets/filter_pill.dart';
import 'package:micro_opportunites/core/ui/widgets/notification_button.dart';
import 'package:micro_opportunites/core/ui/widgets/state_views.dart';
import 'package:micro_opportunites/core/ui/widgets/status_badge.dart';
import 'package:micro_opportunites/core/ui/widgets/step_progress.dart';

/// Vitrine de développement : chaque jeton et composant, pour valider
/// visuellement la base par rapport aux planches Z1–Z3.
class DesignSystemPage extends StatelessWidget {
  const DesignSystemPage({super.key});

  static const _swatches = <(String, Color)>[
    ('Vert Calavi', AppColors.green),
    ('Vert nuit', AppColors.greenDark),
    ('Ocre pièce', AppColors.ochre),
    ('Ocre profond', AppColors.ochreDeep),
    ('Bleu lagune', AppColors.blue),
    ('Rouge alerte', AppColors.red),
    ('Encre', AppColors.ink),
    ('Texte secondaire', AppColors.inkSecondary),
    ('Ligne', AppColors.line),
    ('Fond ivoire', AppColors.ivory),
    ('Carte', AppColors.card),
    ('Vert doux', AppColors.softGreen),
    ('Ocre doux', AppColors.softOchre),
    ('Bleu doux', AppColors.softBlue),
    ('Rouge doux', AppColors.softRed),
  ];

  static void _noop() {}

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.sm);
    return Scaffold(
      appBar: AppBar(title: const Text('Design system')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.xs,
          AppSpacing.screen,
          AppSpacing.xxl,
        ),
        children: [
          _Section(
            title: 'Logo',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AppLogo(variant: AppLogoVariant.mark, size: 56),
                    AppLogo(variant: AppLogoVariant.mark, size: 32),
                    AppLogo(variant: AppLogoVariant.short, size: 40),
                    AppLogo(size: 48),
                  ],
                ),
                gap,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    borderRadius: AppRadius.cardAll,
                  ),
                  child: const Center(
                    child: AppLogo(
                      variant: AppLogoVariant.stackedInverse,
                      size: 72,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _Section(
            title: 'Couleurs',
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final (name, color) in _swatches)
                  _Swatch(name: name, color: color),
              ],
            ),
          ),
          const _Section(
            title: 'Typographie',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Missions près de toi', style: AppTypography.title),
                Text('5 000 FCFA', style: AppTypography.amount),
                Text(
                  'Distribution de flyers au carrefour',
                  style: AppTypography.subtitle,
                ),
                Text(
                  "L'argent reste bloqué jusqu'à la validation.",
                  style: AppTypography.body,
                ),
                Text(
                  'Abomey-Calavi · Sam. 4 oct. · 4 h',
                  style: AppTypography.caption,
                ),
                Text('MO-2026-004812', style: AppTypography.reference),
              ],
            ),
          ),
          const _Section(
            title: 'Boutons',
            child: Column(
              children: [
                AppButton(label: 'Principal', onPressed: _noop),
                gap,
                AppButton(
                  label: 'Argent (payer, verser)',
                  variant: AppButtonVariant.money,
                  onPressed: _noop,
                ),
                gap,
                AppButton(
                  label: 'Secondaire',
                  variant: AppButtonVariant.secondary,
                  onPressed: _noop,
                ),
                gap,
                AppButton(
                  label: 'Destructif',
                  variant: AppButtonVariant.destructive,
                  onPressed: _noop,
                ),
                gap,
                AppButton(label: 'Désactivé · hors-ligne', onPressed: null),
                gap,
                AppButton(
                  label: 'Envoyer',
                  icon: AppIcons.send,
                  onPressed: _noop,
                ),
              ],
            ),
          ),
          const _Section(
            title: 'Champs',
            child: Column(
              children: [
                AppTextField(
                  label: 'Titre de la mission',
                  hint: 'Distribution de flyers',
                ),
                gap,
                AppTextField(
                  label: 'Numéro Mobile Money',
                  hint: '01 97 12 34 56',
                  errorText: 'Numéro incomplet : 10 chiffres attendus.',
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          const _Section(
            title: 'Bascule de profil',
            child: Align(
              alignment: Alignment.centerLeft,
              child: RoleSwitcher(),
            ),
          ),
          const _Section(
            title: 'Filtres',
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                FilterPill(
                  label: 'Tout',
                  state: FilterPillState.selected,
                  onTap: _noop,
                ),
                FilterPill(label: 'Livraison', onTap: _noop),
                FilterPill(label: 'Informatique', onTap: _noop),
                FilterPill(
                  label: '≤ 5 km',
                  state: FilterPillState.applied,
                  onTap: _noop,
                ),
              ],
            ),
          ),
          _Section(
            title: 'Statuts',
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final kind in MissionStatusKind.values) StatusBadge(kind),
              ],
            ),
          ),
          const _Section(
            title: 'Bandeaux',
            child: Column(
              children: [
                AppBanner(
                  title: 'Paiement garanti :',
                  message: '25 000 FCFA sont déjà bloqués pour cette mission.',
                ),
                gap,
                AppBanner(
                  tone: AppBannerTone.todo,
                  title: 'À faire :',
                  message:
                      'validez la fin avant lundi 12 h, sinon le paiement part automatiquement.',
                ),
                gap,
                AppBanner(
                  tone: AppBannerTone.offline,
                  message:
                      'Hors-ligne — vos actions seront envoyées au retour du réseau.',
                ),
                gap,
                AppBanner(
                  tone: AppBannerTone.error,
                  title: 'Paiement refusé',
                  message:
                      "par l'opérateur. Vérifiez votre solde et réessayez.",
                ),
              ],
            ),
          ),
          const _Section(
            title: 'Étapes',
            child: StepProgress(total: 4, current: 2),
          ),
          _Section(
            title: 'Notification flottante',
            child: Builder(
              builder: (context) => AppButton(
                label: 'Afficher',
                variant: AppButtonVariant.secondary,
                expand: false,
                onPressed: () => showAppToast(
                  context,
                  'Candidature envoyée',
                  actionLabel: 'Voir',
                ),
              ),
            ),
          ),
          const _Section(
            title: 'Ligne de liste',
            child: AppListTile(
              leading: AppAvatar(name: 'Rodrigue K.'),
              title: 'Rodrigue K.',
              subtitle: '✓ Vérifié · ★ 4,9 · fiabilité 98 %',
              onTap: _noop,
            ),
          ),
          const _Section(
            title: 'Notifications',
            child: Row(
              children: [
                NotificationButton(unreadCount: 0, onPressed: _noop),
                SizedBox(width: AppSpacing.sm),
                NotificationButton(unreadCount: 2, onPressed: _noop),
              ],
            ),
          ),
          const _Section(
            title: 'État vide',
            child: EmptyState(
              title: 'Pas encore de candidature',
              message: "Les missions de ta zone t'attendent.",
              actionLabel: 'Explorer les missions',
              onAction: _noop,
            ),
          ),
          const _Section(
            title: 'Chargement et erreur',
            child: Column(
              children: [
                SizedBox(height: 80, child: LoadingView()),
                SizedBox(
                  height: 180,
                  child: ErrorView(
                    message: 'Impossible de charger les missions.',
                    onRetry: _noop,
                  ),
                ),
              ],
            ),
          ),
          _Section(
            title: 'Barre de navigation',
            child: AppNavigationBar(
              items: [for (final tab in workerTabs) tab.navigationItem],
              currentIndex: 0,
              onSelected: (_) {},
            ),
          ),
          _Section(
            title: 'Icônes',
            child: Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                for (final icon in AppIcons.values)
                  SizedBox(
                    width: 72,
                    child: Column(
                      children: [
                        AppIcon(icon, size: 28),
                        const SizedBox(height: 6),
                        Text(
                          icon.name,
                          style: AppTypography.caption.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _Section(
            title: 'Illustrations',
            child: Column(
              children: [
                for (final path in AppImages.illustrations)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: AspectRatio(
                        aspectRatio: 350 / 380,
                        child: SvgPicture.asset(path, fit: BoxFit.cover),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.heading),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final hex = color.toARGB32().toRadixString(16).substring(2).toUpperCase();
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppRadius.tileAll,
              border: Border.all(color: AppColors.line),
            ),
          ),
          const SizedBox(height: 6),
          Text(name, style: AppTypography.small),
          Text('#$hex', style: AppTypography.reference.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}
