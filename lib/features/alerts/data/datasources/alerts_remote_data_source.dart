import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/alerts/data/models/mission_alert_model.dart';
import 'package:micro_opportunites/features/alerts/domain/entities/mission_alert.dart';

class AlertsRemoteDataSource {
  AlertsRemoteDataSource(this._api);

  final ApiClient _api;

  Future<List<MissionAlertModel>> fetchAlerts() async {
    final json = await _api.get('/me/alerts') as List<dynamic>;
    return [
      for (final item in json)
        MissionAlertModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  Future<MissionAlertModel> create(AlertDraft draft) async =>
      MissionAlertModel.fromJson(
        await _api.post(
              '/me/alerts',
              body: {
                'keyword': draft.keyword,
                'category': draft.category,
                'zone': draft.zone,
                'minPay': draft.minPay,
                'days': draft.days,
              },
            )
            as Map<String, dynamic>,
      );

  Future<void> delete(String id) => _api.delete('/me/alerts/$id');
}
