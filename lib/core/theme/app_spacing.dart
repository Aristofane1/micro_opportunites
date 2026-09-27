import 'package:flutter/widgets.dart';

/// Espacements (base 4) ; marge d'écran 20.
abstract final class AppSpacing {
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;

  static const double screen = 20;
  static const screenPadding = EdgeInsets.symmetric(horizontal: screen);
}

/// Dimensions minimales imposées par le design.
abstract final class AppSizes {
  static const double minTouchTarget = 44;
  static const double buttonHeight = 52;
  static const double fieldHeight = 48;
  static const double chipHeight = 36;
}
