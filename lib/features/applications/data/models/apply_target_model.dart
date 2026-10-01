import 'package:micro_opportunites/features/applications/domain/entities/apply_target.dart';

/// Extrait de `GET /missions/:id` utile à la feuille Postuler.
class ApplyTargetModel {
  const ApplyTargetModel({
    required this.id,
    required this.title,
    required this.startAt,
    required this.payAmount,
    required this.posterName,
  });

  factory ApplyTargetModel.fromJson(Map<String, dynamic> json) {
    final pay = json['pay'] as Map<String, dynamic>;
    final poster = json['poster'] as Map<String, dynamic>;
    return ApplyTargetModel(
      id: json['id'] as String,
      title: json['title'] as String,
      startAt: json['startAt'] as String,
      payAmount: pay['amount'] as int,
      posterName: poster['displayName'] as String,
    );
  }

  final String id;
  final String title;
  final String startAt;
  final int payAmount;
  final String posterName;

  ApplyTarget toEntity() => ApplyTarget(
    missionId: id,
    title: title,
    startAt: DateTime.parse(startAt),
    payAmount: payAmount,
    posterName: posterName,
  );
}
