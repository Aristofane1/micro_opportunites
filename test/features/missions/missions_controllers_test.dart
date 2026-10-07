import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/core/network/api_exception.dart';
import '../../support/fake_backend/fake_api_client.dart';
import 'package:micro_opportunites/features/account/presentation/controllers/current_user_controller.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_filters.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/explore_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_detail_controller.dart';
import 'package:micro_opportunites/features/missions/presentation/controllers/mission_filters_controller.dart';

import '../../helpers/pump_worker_app.dart';

void main() {
  test('utilisateur courant', () async {
    final container = createTestContainer();
    expect(
      (await container.read(currentUserProvider.future)).firstName,
      'Rodrigue',
    );
  });

  test('Explorer : 7 missions à 5 km, converties en entités', () async {
    final container = createTestContainer();
    final page = await container.read(exploreMissionsProvider.future);
    expect(page.total, 7);
    expect(page.radiusKm, 5);
    final first = page.items.first;
    expect(first.title, 'Distribution de flyers au carrefour');
    expect(first.category, MissionCategory.event);
    expect(first.payAmount, 5000);
    expect(first.slotsFree, 3);
    expect(first.poster.displayName, 'Adjovi H.');
  });

  test('changer les filtres recharge la liste', () async {
    final container = createTestContainer();
    container
        .read(missionFiltersControllerProvider.notifier)
        .apply(const MissionFilters(radiusKm: 20));
    expect((await container.read(exploreMissionsProvider.future)).total, 11);
  });

  test('puces de catégorie rapides', () async {
    final container = createTestContainer();
    final filters = container.read(missionFiltersControllerProvider.notifier);
    filters.selectQuickCategory(MissionCategory.computer);
    expect(container.read(missionFiltersControllerProvider).activeCount, 1);
    expect((await container.read(exploreMissionsProvider.future)).total, 1);
    filters.selectQuickCategory(null);
    expect(
      container.read(missionFiltersControllerProvider).categories,
      isEmpty,
    );
  });

  test('ville choisie sur la carte', () async {
    final container = createTestContainer();
    container
        .read(missionFiltersControllerProvider.notifier)
        .setCity('Cotonou');
    expect((await container.read(exploreMissionsProvider.future)).total, 4);
  });

  test('recherche combinée aux filtres', () async {
    final container = createTestContainer();
    expect(
      (await container.read(searchMissionsProvider('windows').future)).total,
      1,
    );
    expect(
      (await container.read(searchMissionsProvider('plomberie').future)).total,
      0,
    );
  });

  test('aperçu du nombre de missions pour la feuille Filtres', () async {
    final container = createTestContainer();
    final count = await container.read(
      filtersPreviewCountProvider(
        const MissionFilters(
          radiusKm: 20,
          categories: {MissionCategory.cleaning},
        ),
      ).future,
    );
    expect(count, 2);
  });

  test('carte : pastilles par ville et position', () async {
    final container = createTestContainer();
    final map = await container.read(missionMapProvider.future);
    expect(map.clusters.first.city, 'Abomey-Calavi');
    expect(map.clusters.first.count, 7);
    expect(map.clusters.map((c) => c.city), containsAll(['Cotonou', 'Ouidah']));
    expect(map.userLatitude, closeTo(6.4485, 0.0001));
  });

  test('détail de mission et profil annonceur', () async {
    final container = createTestContainer();
    final mission = await container.read(missionDetailProvider('m1').future);
    expect(mission.publicQuestionsCount, 2);
    expect(mission.alreadyApplied, isFalse);
    final poster = await container.read(posterProfileProvider('p1').future);
    expect(poster.rating, 4.8);
    expect(poster.reviews, hasLength(2));
    expect(poster.reviews.last.reply, isNotNull);
  });

  test('Review focus : erreur réseau puis réessai', () async {
    final container = createTestContainer();
    (container.read(apiClientProvider) as FakeApiClient).nextError =
        const ApiException(0, 'hors-ligne');
    final subscription = container.listen(exploreMissionsProvider, (_, _) {});
    await expectLater(
      container.read(exploreMissionsProvider.future),
      throwsA(isA<NetworkFailure>()),
    );
    container.invalidate(exploreMissionsProvider);
    expect((await container.read(exploreMissionsProvider.future)).total, 7);
    subscription.close();
  });
}
