import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/applications/data/models/application_model.dart';
import 'package:micro_opportunites/features/applications/data/models/apply_target_model.dart';

class ApplicationsRemoteDataSource {
  ApplicationsRemoteDataSource(this._api);

  final ApiClient _api;

  Future<List<ApplicationModel>> fetchMyApplications() async {
    final json = await _api.get('/me/applications') as List<dynamic>;
    return [
      for (final item in json)
        ApplicationModel.fromJson(item as Map<String, dynamic>),
    ];
  }

  Future<ApplyTargetModel> fetchApplyTarget(String missionId) async =>
      ApplyTargetModel.fromJson(
        await _api.get('/missions/$missionId') as Map<String, dynamic>,
      );

  Future<ApplicationModel> apply(String missionId, String message) async =>
      ApplicationModel.fromJson(
        await _api.post(
              '/missions/$missionId/applications',
              body: {'message': message},
            )
            as Map<String, dynamic>,
      );

  Future<ApplicationModel> withdraw(String id) => _action(id, 'withdraw');

  Future<ApplicationModel> confirm(String id) => _action(id, 'confirm');

  Future<ApplicationModel> decline(String id) => _action(id, 'decline');

  Future<ApplicationModel> _action(String id, String action) async =>
      ApplicationModel.fromJson(
        await _api.post('/applications/$id/$action') as Map<String, dynamic>,
      );
}
