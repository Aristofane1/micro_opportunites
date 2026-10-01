import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';

abstract interface class AlertsRepository {
  Future<Result<List<MissionAlert>>> fetchAlerts();

  Future<Result<MissionAlert>> createAlert(AlertDraft draft);

  Future<Result<void>> deleteAlert(String id);
}
