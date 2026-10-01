import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission.dart';

part 'mission_page.freezed.dart';

@freezed
abstract class MissionPage with _$MissionPage {
  const factory MissionPage({
    required List<Mission> items,
    required int total,
    required int radiusKm,
    required DateTime updatedAt,
  }) = _MissionPage;
}
