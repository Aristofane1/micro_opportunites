import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/applications/domain/entities/application.dart';
import 'package:micro_opportunites/features/applications/domain/entities/apply_target.dart';

abstract interface class ApplicationsRepository {
  Future<Result<List<Application>>> fetchMyApplications();

  Future<Result<ApplyTarget>> fetchApplyTarget(String missionId);

  Future<Result<Application>> apply({
    required String missionId,
    required String message,
  });

  Future<Result<Application>> withdraw(String applicationId);

  Future<Result<Application>> confirmOffer(String applicationId);

  Future<Result<Application>> declineOffer(String applicationId);
}
