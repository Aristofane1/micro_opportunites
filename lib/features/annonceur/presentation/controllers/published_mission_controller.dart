import 'package:micro_opportunites/features/annonceur/domain/entities/published_mission.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/my_missions_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

part 'published_mission_controller.g.dart';

// Garde la dernière mission publiée (null tant qu'il n'y en a pas).
@Riverpod(keepAlive: true)
class PublishedMissionController extends _$PublishedMissionController {
  @override
  PublishedMission? build() => null;

  // SIMULATION : attend 2 secondes puis "publie"
  // À remplacer par l'appel Firebase / paiement quand l'équipe l'aura prêt.
  Future<void> payAndPublish() async {
    final draft = ref.read(missionDraftControllerProvider);
    await Future<void>.delayed(const Duration(seconds: 2));

    final now = DateTime.now();
    final number = (now.millisecondsSinceEpoch % 1000000).toString().padLeft(
      6,
      '0',
    );
    final mission = PublishedMission(
      id: 'local-${now.millisecondsSinceEpoch}',
      receiptNumber: 'MO-${now.year}-$number',
      draft: draft,
    );
    state = mission;

    // On ajoute la mission à la liste affichée dans « Mes missions »
    ref
        .read(myMissionsControllerProvider.notifier)
        .add(
          MissionSummary(
            id: mission.id,
            title: draft.title ?? 'Mission',
            status: MissionStatus.published,
            startAt: draft.startAt ?? now,
            city: draft.city ?? '',
            payLabel: formatPayPerUnit(draft),
            slotsTotal: draft.slotsTotal,
            blockedAmount: draft.totalToBlock,
            category: draft.category,
            durationMinutes: draft.durationMinutes,
            amountPerSlot: draft.totalToBlock ~/ draft.slotsTotal,
            publishedAt: now,
          ),
        );

    // Le formulaire repart de zéro pour la prochaine mission
    ref.read(missionDraftControllerProvider.notifier).reset();
  }

  void clear() => state = null;
}
