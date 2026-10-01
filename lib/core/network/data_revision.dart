import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_revision.g.dart';

/// Compteur incrémenté après chaque écriture réussie (postuler, confirmer,
/// check-in…). Les providers de lecture le surveillent pour se recharger,
/// sans qu'une feature ait à connaître les providers d'une autre.
@Riverpod(keepAlive: true)
class DataRevision extends _$DataRevision {
  @override
  int build() => 0;

  void bump() => state++;
}
