import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/role_header.dart';
import 'package:micro_opportunites/app/router/shell_tabs.dart';
import 'package:micro_opportunites/core/ui/widgets/app_navigation_bar.dart';

/// Squelette d'un profil : en-tête (bascule + cloche), page de l'onglet,
/// barre de navigation.
class RoleShell extends StatelessWidget {
  const RoleShell({
    super.key,
    required this.navigationShell,
    required this.tabs,
    this.showHeader = true,
  });

  final StatefulNavigationShell navigationShell;
  final List<ShellTab> tabs;

  /// En-tête visible seulement à la racine d'un onglet (B02, B04 n'en ont pas).
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (showHeader) const RoleHeader(),
            Expanded(child: navigationShell),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigationBar(
        items: [for (final tab in tabs) tab.navigationItem],
        currentIndex: navigationShell.currentIndex,
        onSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
