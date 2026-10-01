import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:micro_opportunites/core/formatting/money.dart';

part 'mission_alert.freezed.dart';

/// Valeur par défaut des jours ; non affichée dans le sous-titre.
const everyDayLabel = 'Tous les jours';

@freezed
abstract class MissionAlert with _$MissionAlert {
  const MissionAlert._();

  const factory MissionAlert({
    required String id,
    String? keyword,
    String? category,
    required String zone,
    int? minPay,
    required String days,
  }) = _MissionAlert;

  String get title =>
      keyword != null ? '« $keyword »' : (category ?? 'Toutes catégories');

  /// « Zone · dès 5 000 FCFA · Week-end seulement »
  String get subtitle => [
    zone,
    if (minPay != null) 'dès ${formatFcfa(minPay!)}',
    if (days != everyDayLabel) days,
  ].join(' · ');
}

@freezed
abstract class AlertDraft with _$AlertDraft {
  const factory AlertDraft({
    String? keyword,
    String? category,
    required String zone,
    int? minPay,
    required String days,
  }) = _AlertDraft;
}
