import 'package:flutter/material.dart';

/// Page go_router qui s'affiche en feuille du bas modale (ex. Postuler).
class SheetPage<T> extends Page<T> {
  const SheetPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      settings: this,
      builder: (_) => child,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
    );
  }
}
