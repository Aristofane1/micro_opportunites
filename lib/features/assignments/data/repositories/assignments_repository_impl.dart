import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/network/guard.dart';
import 'package:micro_opportunites/features/assignments/data/datasources/assignments_remote_data_source.dart';
import 'package:micro_opportunites/features/assignments/domain/entities/assignment.dart';
import 'package:micro_opportunites/features/assignments/domain/repositories/assignments_repository.dart';

class AssignmentsRepositoryImpl implements AssignmentsRepository {
  AssignmentsRepositoryImpl(this._remote);

  final AssignmentsRemoteDataSource _remote;

  @override
  Future<Result<Assignment>> fetchAssignment(String id) =>
      guardResult(() async => (await _remote.fetch(id)).toEntity());

  @override
  Future<Result<Assignment>> checkIn(
    String id, {
    required double latitude,
    required double longitude,
  }) => guardResult(
    () async => (await _remote.checkIn(id, latitude, longitude)).toEntity(),
  );

  @override
  Future<Result<Assignment>> checkOut(
    String id, {
    required String note,
    required List<String> photos,
  }) => guardResult(
    () async => (await _remote.checkOut(id, note, photos)).toEntity(),
  );

  @override
  Future<Result<Assignment>> withdraw(String id) =>
      guardResult(() async => (await _remote.withdraw(id)).toEntity());
}
