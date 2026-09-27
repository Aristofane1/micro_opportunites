import 'package:flutter/widgets.dart';

/// Arrondis : 10 champs · 12 lignes · 14 cartes et boutons · pilule.
abstract final class AppRadius {
  static const double field = 10;
  static const double tile = 12;
  static const double card = 14;
  static const double sheet = 20;
  static const double pill = 999;

  static const fieldAll = BorderRadius.all(Radius.circular(field));
  static const tileAll = BorderRadius.all(Radius.circular(tile));
  static const cardAll = BorderRadius.all(Radius.circular(card));
  static const pillAll = BorderRadius.all(Radius.circular(pill));
}
