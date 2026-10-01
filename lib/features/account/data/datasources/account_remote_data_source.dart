import 'package:micro_opportunites/core/network/api_client.dart';
import 'package:micro_opportunites/features/account/data/models/current_user_model.dart';

class AccountRemoteDataSource {
  AccountRemoteDataSource(this._api);

  final ApiClient _api;

  Future<CurrentUserModel> fetchMe() async =>
      CurrentUserModel.fromJson(await _api.get('/me') as Map<String, dynamic>);
}
