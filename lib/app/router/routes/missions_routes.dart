import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/features/account/presentation/widgets/greeting_text.dart';
import 'package:micro_opportunites/features/missions/presentation/pages/explore_page.dart';
import 'package:micro_opportunites/features/missions/presentation/pages/mission_detail_page.dart';
import 'package:micro_opportunites/features/missions/presentation/pages/missions_map_page.dart';
import 'package:micro_opportunites/features/missions/presentation/pages/poster_profile_page.dart';
import 'package:micro_opportunites/features/missions/presentation/pages/search_results_page.dart';

/// Onglet Explorer (B01). La salutation vient de la feature account :
/// c'est `app/` qui compose les features entre elles.
Widget buildExploreTab(BuildContext context) =>
    const ExplorePage(greeting: GreetingText());

/// Sous-pages d'Explorer affichées dans l'onglet (barre visible).
final exploreTabRoutes = <RouteBase>[
  GoRoute(path: 'map', builder: (_, _) => const MissionsMapPage()),
  GoRoute(
    path: 'search',
    builder: (_, state) =>
        SearchResultsPage(query: state.uri.queryParameters['q'] ?? ''),
  ),
];

/// Écrans plein écran, au-dessus de la barre de navigation.
final missionsFullScreenRoutes = <RouteBase>[
  GoRoute(
    path: '/worker/missions/:id',
    builder: (_, state) =>
        MissionDetailPage(missionId: state.pathParameters['id']!),
  ),
  GoRoute(
    path: '/worker/posters/:id',
    builder: (_, state) =>
        PosterProfilePage(posterId: state.pathParameters['id']!),
  ),
];
