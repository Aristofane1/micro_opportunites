import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/my_missions_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annonceur_providers.g.dart';

/// Données de démonstration : faux par défaut, activé par le raccourci de dev.
@Riverpod(keepAlive: true)
bool annonceurDemoData(Ref ref) => false;

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

  return m.copyWith(
    // dès qu'une personne est retenue, la mission passe à « Candidat sélectionné »
    status: m.status == MissionStatus.published && confirmed + offered > 0
        ? MissionStatus.selected
        : m.status,
    slotsConfirmed: confirmed,
    slotsOffered: offered,
    applicantsCount: pending + offered + confirmed,
    newApplicantsCount: pending,
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
