import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/payments_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/screens/validation/complement_sheet.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/candidate_card.dart';

class ValiderTravailScreen extends ConsumerWidget {
  const ValiderTravailScreen({
    super.key,
    required this.missionId,
    required this.candidateId,
  });

  final String missionId;
  final String candidateId;

  static const _green = Color(0xFF1F6B4F);

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Bientôt disponible')));
  }

  void _validate(
    BuildContext context,
    WidgetRef ref,
    Candidate c,
    int amount,
    String missionTitle,
  ) {
    ref.read(candidatesControllerProvider.notifier).validate(missionId, c.id);
    ref
        .read(paymentsControllerProvider.notifier)
        .addPaid(
          missionTitle: missionTitle,
          workerName: c.name,
          amount: amount,
        );
    final messenger = ScaffoldMessenger.of(context);
    context.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          '${formatFcfa(amount)} versés à ${c.firstName} (simulation).',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final mission = ref
        .watch(missionsWithCountsProvider)
        .where((m) => m.id == missionId)
        .firstOrNull;
    final c = ref.watch(
      candidatesControllerProvider.select(
        (m) => (m[missionId] ?? const <Candidate>[])
            .where((x) => x.id == candidateId)
            .firstOrNull,
      ),
    );

    if (mission == null || c == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Introuvable.')),
      );
    }

    final amount = mission.amountPerSlot + c.bonusAmount;
    final canValidate = c.attendance == AttendanceStatus.finished;
    final arrived = c.arrivedAt;
    final finished = c.finishedAt;
    final autoPayAt = c.autoPayAt;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- En-tête ---
                    Row(
                      children: [
                        IconButton.outlined(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mission.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                              const Text(
                                'Valider le travail',
                                style: TextStyle(
                                  fontFamily: 'Lora',
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // --- Qui ---
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        border: Border.all(color: colors.outlineVariant),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CandidateAvatar(c, size: 48),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  finished == null
                                      ? 'n\'a pas encore signalé la fin'
                                      : 'a signalé la fin à ${formatHour(finished)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton.outlined(
                            onPressed: () =>
                                _soon(context), // messagerie à venir
                            icon: const Icon(Icons.chat_bubble_outline),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // --- Complément proposé ---
                    if (c.bonusAmount > 0) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDDEEE6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Complément de ${formatFcfa(c.bonusAmount)} proposé · '
                          'en attente d\'acceptation'
                          '${c.bonusReason == null ? '' : ' (${c.bonusReason})'}',
                          style: const TextStyle(color: _green),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // --- Litige ouvert ---
                    if (c.attendance == AttendanceStatus.disputed) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDEAE7),
                          border: Border.all(color: const Color(0xFFB42318)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Litige ouvert : ${c.disputeReason ?? ''}. Les '
                          '${formatFcfa(amount)} restent bloqués pendant l\'examen.',
                          style: const TextStyle(color: Color(0xFF7A1F16)),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    // --- Preuves ---
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        border: Border.all(color: colors.outlineVariant),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preuves',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _ProofLine(
                            title:
                                'Arrivée ${arrived == null ? '–' : formatHour(arrived)}',
                            detail:
                                '${c.distanceMeters == null ? '' : '${c.distanceMeters} m du lieu · '}'
                                '${c.gpsPrecise ? 'GPS précis' : 'GPS approximatif'}',
                          ),
                          const SizedBox(height: 10),
                          _ProofLine(
                            title:
                                'Départ ${finished == null ? '–' : formatHour(finished)}',
                            detail: arrived != null && finished != null
                                ? '${formatDuration(finished.difference(arrived).inMinutes)} sur place'
                                : 'durée inconnue',
                          ),
                          const SizedBox(height: 14),
                          if (c.proofPhotos == 0)
                            Text(
                              'Aucune photo jointe.',
                              style: TextStyle(color: colors.onSurfaceVariant),
                            )
                          else
                            Row(
                              children: [
                                for (
                                  var i = 0;
                                  i < c.proofPhotos && i < 2;
                                  i++
                                ) ...[
                                  if (i > 0) const SizedBox(width: 8),
                                  // emplacement de la photo (Firebase Storage plus tard)
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      padding: const EdgeInsets.all(6),
                                      alignment: Alignment.bottomLeft,
                                      decoration: BoxDecoration(
                                        color: colors.surfaceContainerHigh,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'photo ${i + 1}',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          if (c.completionNote != null) ...[
                            const SizedBox(height: 14),
                            Text(
                              '« ${c.completionNote} »',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // --- Paiement automatique ---
                    if (autoPayAt != null && canValidate)
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBEFE0),
                          border: Border.all(color: const Color(0xFFE8B66B)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(color: Color(0xFF7A4A0A)),
                            children: [
                              const TextSpan(text: 'Sans réponse avant '),
                              TextSpan(
                                text:
                                    '${formatDayLong(autoPayAt)} ${formatHour(autoPayAt)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text: ', le paiement part automatiquement.',
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // --- Actions ---
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(top: BorderSide(color: colors.outlineVariant)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: canValidate
                          ? () => _validate(
                              context,
                              ref,
                              c,
                              amount,
                              mission.title,
                            )
                          : null,
                      child: Text(
                        canValidate
                            ? 'Valider et verser ${formatFcfa(amount)}'
                            : c.attendance == AttendanceStatus.disputed
                            ? 'Litige en cours'
                            : 'Paiement déjà versé',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: canValidate
                              ? () => showComplementSheet(
                                  context,
                                  missionId: missionId,
                                  candidate: c,
                                )
                              : null,
                          child: const Text('Ajouter un complément'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colors.error,
                          ),
                          onPressed: canValidate
                              ? () => context.push(
                                  AppRoutes.posterProblem(missionId, c.id),
                                )
                              : null,
                          child: const Text('Signaler un problème'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Une ligne de preuve : point vert, titre, détail
class _ProofLine extends StatelessWidget {
  const _ProofLine({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF1F6B4F),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
