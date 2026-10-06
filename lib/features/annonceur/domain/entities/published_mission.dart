import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';

/// Une mission une fois payée et publiée.
class PublishedMission {
  const PublishedMission({
    required this.id,
    required this.receiptNumber,
    required this.draft,
  });

  final String id;
  final String receiptNumber; // ex. MO-2026-005130
  final MissionDraft draft; // copie du brouillon au moment de la publication
}
