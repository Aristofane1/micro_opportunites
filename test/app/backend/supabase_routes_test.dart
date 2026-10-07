import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/backend/supabase_routes.dart';

import '../../support/fake_backend/fake_api_client.dart';

void main() {
  test('chaque route du faux serveur a son équivalent Supabase', () {
    for (final route in FakeApiClient.routeSignatures) {
      if (route.$2.startsWith('/auth/login') ||
          route.$2 == '/auth/signup' ||
          route.$2 == '/auth/logout') {
        continue;
      }
      expect(
        supabaseRoutes.any(
          (r) => r.method == route.$1 && r.pattern == route.$2,
        ),
        isTrue,
        reason: 'route manquante : ${route.$1} ${route.$2}',
      );
    }
  });

  test('paramètres de chemin, requête et corps transmis à la RPC', () {
    final route = matchRoute('POST', '/missions/m20/applications')!;
    expect(route.route.rpc, 'apply_to_mission');
    expect(
      route.route.args(route.params, const {}, const {'message': 'Dispo'}),
      {'mission_id': 'm20', 'message': 'Dispo'},
    );
    final list = matchRoute('GET', '/missions')!;
    expect(
      list.route.args(const {}, const {
        'km': '20',
        'q': 'flyers',
      }, const {})['km'],
      20,
    );
  });

  test(
    'ordre : /missions/cities avant /missions/:id, /me/missions avant /me/missions/:id',
    () {
      expect(matchRoute('GET', '/missions/cities')!.route.rpc, 'list_cities');
      expect(matchRoute('GET', '/me/missions')!.route.rpc, 'list_my_missions');
    },
  );

  test('conversion des filtres : km et min en entiers, multi en booléen', () {
    final args = matchRoute('GET', '/missions')!.route.args(const {}, const {
      'km': '5',
      'min': '3000',
      'multi': 'true',
      'cat': 'flyers,event',
      'when': 'today',
      'city': 'Cotonou',
    }, const {});
    expect(args, {
      'km': 5,
      'cat': 'flyers,event',
      'min': 3000,
      'when': 'today',
      'multi': true,
      'city': 'Cotonou',
      'q': null,
    });
  });

  test(
    'position de l’appareil : lat et lng en réels, seulement si présents',
    () {
      final route = matchRoute('GET', '/missions')!.route;
      final withPosition = route.args(const {}, const {
        'km': '5',
        'lat': '6.3667',
        'lng': '2.085',
      }, const {});
      expect(withPosition['lat'], 6.3667);
      expect(withPosition['lng'], 2.085);
      final without = route.args(const {}, const {'km': '5'}, const {});
      expect(without.containsKey('lat'), isFalse);
      expect(without.containsKey('lng'), isFalse);
      final partial = route.args(const {}, const {'lat': '6.3667'}, const {});
      expect(partial.containsKey('lat'), isFalse);
    },
  );

  test('corps traduits vers les noms des paramètres SQL', () {
    Map<String, Object?> argsOf(
      String method,
      String path,
      Map<String, Object?> body,
    ) {
      final match = matchRoute(method, path)!;
      return match.route.args(match.params, const {}, body);
    }

    expect(
      argsOf('POST', '/auth/profile', const {
        'firstName': 'Awa',
        'lastName': 'Dossou',
        'birthDate': '2000-01-01',
        'acceptTerms': true,
        'acceptNewsletter': false,
      }),
      {
        'first_name': 'Awa',
        'last_name': 'Dossou',
        'birth_date': '2000-01-01',
        'accept_terms': true,
        'accept_newsletter': false,
      },
    );
    expect(
      argsOf('POST', '/auth/kyc', const {
        'documentType': 'passport',
        'countryCode': 'BJ',
        'frontPath': 'u/x/front.jpg',
        'selfiePath': 'u/x/selfie.jpg',
      }),
      {
        'document_type': 'passport',
        'country_code': 'BJ',
        'front_path': 'u/x/front.jpg',
        'back_path': null,
        'selfie_path': 'u/x/selfie.jpg',
      },
    );
    expect(
      argsOf('POST', '/me/alerts', const {
        'keyword': 'flyers',
        'category': null,
        'zone': 'Calavi',
        'minPay': 2000,
        'days': 'we',
      }),
      {
        'keyword': 'flyers',
        'category': null,
        'zone': 'Calavi',
        'min_pay': 2000,
        'days': 'we',
      },
    );
    expect(
      argsOf('POST', '/assignments/as1/check-in', const {
        'lat': 6.4,
        'lng': 2.3,
      }),
      {'id': 'as1', 'lat': 6.4, 'lng': 2.3},
    );
    expect(
      argsOf('POST', '/assignments/as1/check-out', const {
        'note': 'Fait',
        'photos': ['a'],
      }),
      {
        'id': 'as1',
        'note': 'Fait',
        'photos': ['a'],
      },
    );
    expect(
      argsOf('POST', '/assignments/as1/contest', const {'reason': 'Non'}),
      {'id': 'as1', 'reason': 'Non'},
    );
    expect(argsOf('POST', '/missions', const {'title': 'T'}), {
      'body': {'title': 'T'},
    });
    expect(argsOf('GET', '/missions/m1/candidates', const {}), {
      'mission_id': 'm1',
    });
    expect(argsOf('DELETE', '/me/alerts/al1', const {}), {'id': 'al1'});
    expect(argsOf('POST', '/me/role', const {'role': 'poster'}), {
      'role': 'poster',
    });
    expect(argsOf('GET', '/me', const {}), isEmpty);
  });

  test('chemin inconnu ou mauvaise méthode : pas de route', () {
    expect(matchRoute('GET', '/inconnu'), isNull);
    expect(matchRoute('DELETE', '/missions/m1'), isNull);
  });
}
