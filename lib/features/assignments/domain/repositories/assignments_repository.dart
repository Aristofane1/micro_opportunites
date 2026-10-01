import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';

abstract interface class AssignmentsRepository {
  Future<Result<Assignment>> fetchAssignment(String id);

  Future<Result<Assignment>> checkIn(
    String id, {
    required double latitude,
    required double longitude,
  });

  Future<Result<Assignment>> checkOut(
    String id, {
    required String note,
    required List<String> photos,
  });

  Future<Result<Assignment>> withdraw(String id);
}
