import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_entry.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/my_missions_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/payments_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annonceur_providers.g.dart';

/// Les missions avec leurs compteurs calculés à partir des candidats.
/// C'est CETTE liste que les écrans doivent lire.
@Riverpod(keepAlive: true)
List<MissionSummary> missionsWithCounts(Ref ref) {
  final missions = ref.watch(myMissionsControllerProvider);
  final candidates = ref.watch(candidatesControllerProvider);

  return [
    for (final m in missions)
      if (candidates[m.id] case final list?) _merge(m, list) else m,
  ];
}

MissionSummary _merge(MissionSummary m, List<Candidate> list) {
  int count(CandidateStatus s) => list.where((c) => c.status == s).length;
  final confirmed = count(CandidateStatus.confirmed);
  final offered = count(CandidateStatus.retained);
  final pending = count(CandidateStatus.pending);

  final workers = list
      .where((c) => c.status == CandidateStatus.confirmed)
      .toList();
  // les compléments proposés s'ajoutent à l'argent bloqué
  final bonus = workers.fold<int>(0, (sum, c) => sum + c.bonusAmount);
  // ce qui a déjà été versé : part de base + complément de chaque personne payée
  final paid = workers
      .where((c) => c.attendance == AttendanceStatus.validated)
      .fold<int>(0, (sum, c) => sum + m.amountPerSlot + c.bonusAmount);

  return m.copyWith(
    status: m.status == MissionStatus.published && confirmed + offered > 0
        ? MissionStatus.selected
        : m.status,
    slotsConfirmed: confirmed,
    slotsOffered: offered,
    applicantsCount: pending + offered + confirmed,
    newApplicantsCount: pending,
    blockedAmount: m.blockedAmount + bonus,
    paidAmount: paid,
  );
}

/// Un travail terminé, en attente de validation par l'annonceur.
class PendingValidation {
  const PendingValidation({required this.missionId, required this.candidate});
  final String missionId;
  final Candidate candidate;
}

@Riverpod(keepAlive: true)
List<PendingValidation> pendingValidations(Ref ref) {
  final all = ref.watch(candidatesControllerProvider);
  return [
    for (final entry in all.entries)
      for (final c in entry.value)
        if (c.attendance == AttendanceStatus.finished)
          PendingValidation(missionId: entry.key, candidate: c),
  ];
}

/// Les lignes de l'écran Paiements : l'argent bloqué (calculé à partir des
/// missions actives) + les paiements déjà faits, du plus récent au plus ancien.
@Riverpod(keepAlive: true)
List<PaymentEntry> paymentRows(Ref ref) {
  final missions = ref.watch(missionsWithCountsProvider);
  final events = ref.watch(paymentsControllerProvider);

  final blocked = [
    for (final m in missions)
      if (m.status.isActive && m.blockedNow > 0)
        PaymentEntry(
          id: 'blocked-${m.id}',
          title: m.title,
          kind: PaymentKind.blocked,
          amount: m.blockedNow,
          date: m.publishedAt ?? m.startAt,
        ),
  ];

  return [...blocked, ...events]..sort((a, b) => b.date.compareTo(a.date));
}
