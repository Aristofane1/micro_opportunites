import 'package:micro_opportunites/core/dev/dev_start.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/my_missions_controller.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'candidates_controller.g.dart';

/// Les candidats de chaque mission : identifiant de mission -> liste.
/// À REMPLACER par Firestore quand Firebase sera branché.
@Riverpod(keepAlive: true)
class CandidatesController extends _$CandidatesController {
  @override
  Map<String, List<Candidate>> build() =>
      startOnPublish ? _demoCandidates() : const {};

  void _update(
    String missionId,
    String candidateId,
    Candidate Function(Candidate) change,
  ) {
    final list = state[missionId];
    if (list == null) return;
    state = {
      ...state,
      missionId: [for (final c in list) c.id == candidateId ? change(c) : c],
    };
  }

  /// Retient un candidat. Renvoie false s'il n'y a plus de place libre.
  bool retain(String missionId, String candidateId) {
    final total =
        ref
            .read(myMissionsControllerProvider)
            .where((m) => m.id == missionId)
            .firstOrNull
            ?.slotsTotal ??
        0;
    final taken = (state[missionId] ?? const <Candidate>[])
        .where(
          (c) =>
              c.status == CandidateStatus.retained ||
              c.status == CandidateStatus.confirmed,
        )
        .length;
    if (taken >= total) return false;

    _update(
      missionId,
      candidateId,
      (c) => c.copyWith(status: CandidateStatus.retained),
    );
    return true;
  }

  void refuse(String missionId, String candidateId) => _update(
    missionId,
    candidateId,
    (c) => c.copyWith(status: CandidateStatus.refused),
  );

  /// L'annonceur confirme la présence d'une personne (GPS faible).
  void confirmPresence(String missionId, String candidateId) => _update(
    missionId,
    candidateId,
    (c) => c.copyWith(
      attendance: AttendanceStatus.arrived,
      arrivedAt: c.arrivedAt ?? DateTime.now(),
    ),
  );

  /// Valide le travail : le paiement est versé (SIMULATION).
  void validate(String missionId, String candidateId) => _update(
    missionId,
    candidateId,
    (c) => c.copyWith(attendance: AttendanceStatus.validated),
  );
}

// Données d'exemple, seulement avec --dart-define=START=publish
Map<String, List<Candidate>> _demoCandidates() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final finishedAt = now.subtract(const Duration(hours: 2));

  // Une personne retenue et présente sur la mission du jour
  Candidate worker(
    String id,
    String name,
    AttendanceStatus attendance, {
    DateTime? arrivedAt,
    DateTime? noCheckInAt,
    bool gpsPrecise = true,
  }) => Candidate(
    id: id,
    name: name,
    city: 'Godomey',
    memberSince: 'janv. 2026',
    pitch: '',
    skills: '',
    verified: true,
    status: CandidateStatus.confirmed,
    attendance: attendance,
    arrivedAt: arrivedAt,
    noCheckInAt: noCheckInAt,
    gpsPrecise: gpsPrecise,
  );

  // Un candidat en attente
  Candidate applicant(
    String id,
    String name,
    String pitch, {
    double? rating,
    int missions = 0,
    int? reliability,
  }) => Candidate(
    id: id,
    name: name,
    city: 'Godomey',
    memberSince: 'janv. 2026',
    pitch: pitch,
    skills: 'Accueil, relation client.',
    verified: true,
    rating: rating,
    missionsCount: missions,
    reviewsCount: missions,
    reliability: reliability,
  );

  return {
    // Mission en cours : suivi du jour
    'demo-1': [
      worker(
        'rk',
        'Rodrigue K.',
        AttendanceStatus.finished,
        arrivedAt: finishedAt.subtract(const Duration(hours: 4, minutes: 9)),
      ).copyWith(
        finishedAt: finishedAt,
        distanceMeters: 40,
        proofPhotos: 2,
        completionNote:
            'Tous les flyers distribués, t-shirt rendu à l\'accueil.',
      ),
      worker(
        'ma',
        'Mireille A.',
        AttendanceStatus.arrived,
        arrivedAt: today.add(const Duration(hours: 8, minutes: 2)),
      ),
      worker(
        'so',
        'Sènami O.',
        AttendanceStatus.arrived,
        arrivedAt: today.add(const Duration(hours: 7, minutes: 48)),
      ),
      worker('ga', 'Grâce A.', AttendanceStatus.unconfirmed, gpsPrecise: false),
      worker(
        'jb',
        'Jonas B.',
        AttendanceStatus.absent,
        noCheckInAt: today.add(const Duration(hours: 8, minutes: 31)),
      ),
    ],
    // Mission publiée : candidats à examiner
    'demo-2': [
      Candidate(
        id: 'so2',
        name: 'Sènami O.',
        city: 'Godomey',
        memberSince: 'janv. 2026',
        pitch: 'J\'habite Godomey, je peux venir avec une amie déjà inscrite.',
        skills:
            'Accueil, service, parle fon et français, sait conduire une moto.',
        verified: true,
        isExpert: true,
        rating: 4.9,
        reviewsCount: 16,
        missionsCount: 18,
        reliability: 99,
        doneMissions: const [
          DoneMission(MissionCategory.event, 9),
          DoneMission(MissionCategory.flyers, 5),
          DoneMission(MissionCategory.shopping, 4),
        ],
        review: const CandidateReview(
          author: 'Boutique Lumière',
          stars: 5,
          text: 'Ponctuelle, très à l\'aise avec les clients.',
          punctuality: 5,
          quality: 5,
          communication: 5,
        ),
      ),
      applicant('jb2', 'Jonas B.', 'Étudiant, disponible tout le samedi.'),
      applicant(
        'ma2',
        'Mireille A.',
        'Je suis rapide et soigneuse.',
        rating: 4.7,
        missions: 11,
        reliability: 97,
      ),
      applicant(
        'rk2',
        'Rodrigue K.',
        'Disponible dès lundi.',
        rating: 4.8,
        missions: 14,
        reliability: 98,
      ),
    ],
  };
}
