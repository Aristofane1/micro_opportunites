import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/ui/widgets/app_avatar.dart';
import 'package:micro_opportunites/core/ui/widgets/app_banner.dart';
import 'package:micro_opportunites/core/ui/widgets/app_list_tile.dart';
import 'package:micro_opportunites/core/ui/widgets/app_navigation_bar.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/core/ui/widgets/empty_state.dart';
import 'package:micro_opportunites/core/ui/widgets/filter_pill.dart';
import 'package:micro_opportunites/core/ui/widgets/notification_button.dart';
import 'package:micro_opportunites/core/ui/widgets/state_views.dart';
import 'package:micro_opportunites/core/ui/widgets/status_badge.dart';
import 'package:micro_opportunites/core/ui/widgets/step_progress.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('StatusBadge affiche les 12 libellés du design', (tester) async {
    await tester.pumpThemed(
      Wrap(
        children: [
          for (final kind in MissionStatusKind.values) StatusBadge(kind),
        ],
      ),
    );
    expect(MissionStatusKind.values, hasLength(12));
    for (final kind in MissionStatusKind.values) {
      expect(find.text(kind.label), findsOneWidget);
    }
  });

  testWidgets('M5 : Review focus : StatusBadge tronque dans un espace étroit', (
    tester,
  ) async {
    await tester.pumpThemed(
      const SizedBox(
        width: 120,
        child: Row(
          children: [
            Flexible(child: StatusBadge(MissionStatusKind.completedPaid)),
          ],
        ),
      ),
      textScale: 2,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('FilterPill appelle onTap et annonce sa sélection', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await tester.pumpThemed(
      FilterPill(
        label: '≤ 5 km',
        state: FilterPillState.applied,
        onTap: () => taps++,
      ),
    );
    await tester.tap(find.text('≤ 5 km'));
    expect(taps, 1);
    expect(
      tester.getSemantics(find.byType(FilterPill)),
      matchesSemantics(
        label: '≤ 5 km',
        hint: 'Toucher pour retirer',
        isButton: true,
        hasSelectedState: true,
        isSelected: true,
        hasTapAction: true,
        isFocusable: true,
        hasFocusAction: true,
      ),
    );
    handle.dispose();
  });

  testWidgets(
    'M4 : Review focus : FilterPill garde un visuel 36 px mais une zone '
    'tactile ≥ 44 px',
    (tester) async {
      await tester.pumpThemed(FilterPill(label: 'Tout', onTap: () {}));
      expect(
        tester.getSize(find.byType(FilterPill)).height,
        greaterThanOrEqualTo(44),
      );
    },
  );

  testWidgets('AppBanner affiche titre et message', (tester) async {
    await tester.pumpThemed(
      const AppBanner(
        tone: AppBannerTone.todo,
        title: 'À faire :',
        message: 'validez la fin avant lundi 12 h.',
      ),
    );
    expect(
      find.textContaining('À faire :', findRichText: true),
      findsOneWidget,
    );
    expect(
      find.textContaining('validez la fin', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('showAppToast affiche le message et l’action', (tester) async {
    await tester.pumpThemed(
      Builder(
        builder: (context) => TextButton(
          onPressed: () =>
              showAppToast(context, 'Candidature envoyée', actionLabel: 'Voir'),
          child: const Text('go'),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pump();
    expect(find.text('Candidature envoyée'), findsOneWidget);
    expect(find.text('Voir'), findsOneWidget);
  });

  testWidgets('EmptyState déclenche son action', (tester) async {
    var taps = 0;
    await tester.pumpThemed(
      EmptyState(
        title: 'Pas encore de candidature',
        message: "Les missions de ta zone t'attendent.",
        actionLabel: 'Explorer les missions',
        onAction: () => taps++,
      ),
    );
    await tester.tap(find.text('Explorer les missions'));
    expect(taps, 1);
  });

  testWidgets('StepProgress annonce l’étape', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpThemed(const StepProgress(total: 4, current: 2));
    expect(find.bySemanticsLabel('Étape 2 sur 4'), findsOneWidget);
    handle.dispose();
  });

  test('AppAvatar.initialsOf', () {
    expect(AppAvatar.initialsOf('Rodrigue K.'), 'RK');
    expect(AppAvatar.initialsOf('  awa  '), 'A');
    expect(AppAvatar.initialsOf('Jean Paul Kossi'), 'JP');
    expect(AppAvatar.initialsOf('   '), '?');
  });

  testWidgets('AppListTile : titre, sous-titre, appui', (tester) async {
    var taps = 0;
    await tester.pumpThemed(
      AppListTile(
        leading: const AppAvatar(name: 'Rodrigue K.'),
        title: 'Rodrigue K.',
        subtitle: '★ 4,9 · fiabilité 98 %',
        onTap: () => taps++,
      ),
    );
    await tester.tap(find.text('Rodrigue K.'));
    expect(taps, 1);
    expect(find.text('★ 4,9 · fiabilité 98 %'), findsOneWidget);
  });

  testWidgets(
    'M7 : Review focus : AppListTile fusionne sa sémantique en un seul nœud',
    (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpThemed(
        AppListTile(
          title: 'Rodrigue K.',
          subtitle: '★ 4,9 · fiabilité 98 %',
          showChevron: false,
          onTap: () {},
        ),
      );
      final semantics = tester.getSemantics(find.byType(AppListTile));
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.label, contains('Rodrigue K.'));
      expect(semantics.label, contains('★ 4,9 · fiabilité 98 %'));
      handle.dispose();
    },
  );

  testWidgets('ErrorView.failure affiche le message et relance', (
    tester,
  ) async {
    var retries = 0;
    await tester.pumpThemed(
      SizedBox(
        height: 300,
        child: ErrorView.failure(
          const NetworkFailure(),
          onRetry: () => retries++,
        ),
      ),
    );
    expect(find.text(const NetworkFailure().message), findsOneWidget);
    await tester.tap(find.text('Réessayer'));
    expect(retries, 1);
  });

  testWidgets('M7 : Review focus : ErrorView annonce le message en direct', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpThemed(
      const SizedBox(height: 300, child: ErrorView(message: 'Oups')),
    );
    expect(
      tester.getSemantics(find.text('Oups')).flagsCollection.isLiveRegion,
      isTrue,
    );
    handle.dispose();
  });

  testWidgets('LoadingView affiche un indicateur', (tester) async {
    await tester.pumpThemed(const LoadingView(message: 'Chargement…'));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Chargement…'), findsOneWidget);
  });

  testWidgets(
    'M7 : Review focus : LoadingView annonce un message unique (avec/sans '
    'message)',
    (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpThemed(const LoadingView(message: 'Chargement…'));
      expect(find.bySemanticsLabel('Chargement…'), findsOneWidget);
      handle.dispose();
    },
  );

  testWidgets(
    'M7 : Review focus : LoadingView annonce un message par défaut sans '
    'message',
    (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpThemed(const LoadingView());
      expect(find.bySemanticsLabel('Chargement en cours'), findsOneWidget);
      handle.dispose();
    },
  );

  testWidgets(
    'NotificationButton annonce les non-lus, s’active au tap et expose '
    'une action sémantique',
    (tester) async {
      final handle = tester.ensureSemantics();
      var taps = 0;
      await tester.pumpThemed(
        Row(
          children: [
            NotificationButton(unreadCount: 0, onPressed: () {}),
            NotificationButton(unreadCount: 1, onPressed: () {}),
            NotificationButton(unreadCount: 2, onPressed: () => taps++),
          ],
        ),
      );
      expect(find.bySemanticsLabel('Notifications'), findsOneWidget);
      expect(find.bySemanticsLabel('Notifications, 1 non lue'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Notifications, 2 non lues'),
        findsOneWidget,
      );

      await tester.tap(find.bySemanticsLabel('Notifications, 2 non lues'));
      expect(taps, 1);

      expect(
        tester.getSemantics(find.bySemanticsLabel('Notifications, 2 non lues')),
        matchesSemantics(
          label: 'Notifications, 2 non lues',
          isButton: true,
          hasTapAction: true,
          hasEnabledState: true,
          isEnabled: true,
        ),
      );
      handle.dispose();
    },
  );

  testWidgets(
    'M7 : Review focus : NotificationButton sans onPressed est annoncé '
    'désactivé',
    (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpThemed(
        const NotificationButton(unreadCount: 0, onPressed: null),
      );
      expect(
        tester.getSemantics(find.bySemanticsLabel('Notifications')),
        matchesSemantics(
          label: 'Notifications',
          isButton: true,
          hasEnabledState: true,
          isEnabled: false,
        ),
      );
      handle.dispose();
    },
  );

  testWidgets('AppNavigationBar sélectionne un onglet', (tester) async {
    final handle = tester.ensureSemantics();
    int? selected;
    await tester.pumpThemed(
      AppNavigationBar(
        items: const [
          AppNavigationItem(icon: AppIcons.explore, label: 'Explorer'),
          AppNavigationItem(icon: AppIcons.applications, label: 'Candidatures'),
        ],
        currentIndex: 0,
        onSelected: (index) => selected = index,
      ),
    );
    await tester.tap(find.text('Candidatures'));
    expect(selected, 1);
    expect(
      tester.getSemantics(find.text('Explorer')),
      matchesSemantics(
        label: 'Explorer',
        isButton: true,
        hasSelectedState: true,
        isSelected: true,
        hasTapAction: true,
        isFocusable: true,
        hasFocusAction: true,
      ),
    );
    handle.dispose();
  });
}
