import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';

part 'mission_alert_model.freezed.dart';
part 'mission_alert_model.g.dart';

@freezed
abstract class MissionAlertModel with _$MissionAlertModel {
  const MissionAlertModel._();

  const factory MissionAlertModel({
    required String id,
    String? keyword,
    String? category,
    required String zone,
    int? minPay,
    required String days,
  }) = _MissionAlertModel;

  factory MissionAlertModel.fromJson(Map<String, dynamic> json) =>
      _$MissionAlertModelFromJson(json);

  MissionAlert toEntity() => MissionAlert(
    id: id,
    keyword: keyword,
    category: category,
    zone: zone,
    minPay: minPay,
    days: days,
  );
}
