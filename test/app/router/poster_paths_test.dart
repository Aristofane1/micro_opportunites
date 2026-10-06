import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';

void main() {
  test('chemins annonceur', () {
    expect(PosterPaths.missions, '/poster/missions');
    expect(PosterPaths.publishNew, '/poster/publish/new');
    expect(PosterPaths.missionManage('m20'), '/poster/missions/manage/m20');
    expect(
      PosterPaths.candidates('m20'),
      '/poster/missions/manage/m20/candidates',
    );
    expect(
      PosterPaths.candidate('m20', 'a1'),
      '/poster/missions/manage/m20/candidate/a1',
    );
    expect(PosterPaths.today('m20'), '/poster/missions/manage/m20/today');
    expect(
      PosterPaths.validate('m20', 'as1'),
      '/poster/missions/manage/m20/validate/as1',
    );
    expect(
      PosterPaths.contest('m20', 'as1'),
      '/poster/missions/manage/m20/contest/as1',
    );
    expect(PosterPaths.cancel('m20'), '/poster/missions/manage/m20/cancel');
    expect(AppRoutes.posterMissions, PosterPaths.missions);
  });
}
