import 'package:freezed_annotation/freezed_annotation.dart';

part 'apply_target.freezed.dart';

/// Ce que la feuille Postuler (B06) affiche de la mission visée.
@freezed
abstract class ApplyTarget with _$ApplyTarget {
  const factory ApplyTarget({
    required String missionId,
    required String title,
    required DateTime startAt,
    required int payAmount,
    required String posterName,
  }) = _ApplyTarget;
}
