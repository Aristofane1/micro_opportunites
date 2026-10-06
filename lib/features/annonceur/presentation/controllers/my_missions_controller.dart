import 'package:micro_opportunites/core/dev/dev_start.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_status.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

part 'my_missions_controller.g.dart';

/* Les missions de l'Annonceur, gardées en mémoire.
 À REMPLACER par un flux Firestore quand Firebase sera branché.*/
@Riverpod(keepAlive: true)
class MyMissionsController extends _$MyMissionsController {
  @override
  List<MissionSummary> build() => startOnPublish ? _demoMissions() : const [];

  void add(MissionSummary mission) => state = [mission, ...state];

  void remove(String id) => state = state.where((m) => m.id != id).toList();
}

// Deux missions d'exemple (celles de la maquette), seulement avec START=publish
List<MissionSummary> _demoMissions() {
  final now = DateTime.now();
  return [
    MissionSummary(
      id: 'demo-1',
      title: 'Distribution de flyers au carrefour',
      status: MissionStatus.inProgress,
      category: MissionCategory.event,
      startAt: DateTime(now.year, now.month, now.day, 8), // aujourd'hui 8 h
      city: 'Godomey',
      payLabel: '5 000 FCFA / pers.',
      slotsTotal: 5,
      blockedAmount: 25000,
    ),
    MissionSummary(
      id: 'demo-2',
      title: 'Saisie de 300 fiches clients',
      status: MissionStatus.published,
      category: MissionCategory.dataEntry,
      startAt: DateTime(now.year, now.month, now.day + 4, 14),
      city: 'Cotonou',
      payLabel: '15 000 FCFA / pers.',
      slotsTotal: 3,
      blockedAmount: 45000,
    ),
  ];
}
