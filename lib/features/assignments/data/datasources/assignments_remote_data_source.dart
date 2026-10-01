import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/assignments/data/models/assignment_model.dart';

class AssignmentsRemoteDataSource {
  AssignmentsRemoteDataSource(this._api);

  final ApiClient _api;

  Future<AssignmentModel> fetch(String id) async =>
      _parse(await _api.get('/assignments/$id'));

  Future<AssignmentModel> checkIn(
    String id,
    double latitude,
    double longitude,
  ) async => _parse(
    await _api.post(
      '/assignments/$id/check-in',
      body: {'lat': latitude, 'lng': longitude},
    ),
  );

  Future<AssignmentModel> checkOut(
    String id,
    String note,
    List<String> photos,
  ) async => _parse(
    await _api.post(
      '/assignments/$id/check-out',
      body: {'note': note, 'photos': photos},
    ),
  );

  Future<AssignmentModel> withdraw(String id) async =>
      _parse(await _api.post('/assignments/$id/withdraw'));

  AssignmentModel _parse(Object? json) =>
      AssignmentModel.fromJson(json! as Map<String, dynamic>);
}
