import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/app/backend/config_error_app.dart';
import 'package:micro_opportunites/app/backend/supabase_config.dart';

void main() {
  testWidgets('sans clés Supabase : écran d’erreur de configuration', (
    tester,
  ) async {
    await tester.pumpWidget(const ConfigErrorApp());
    expect(find.text('Configuration Supabase manquante.'), findsOneWidget);
    expect(
      find.text('Lancez l’app avec --dart-define-from-file=env/dev.json.'),
      findsOneWidget,
    );
  });

  test(
    'sans --dart-define, aucune clé n’est lue',
    () => expect(readSupabaseKeys(), isNull),
    // Lancée avec --dart-define-from-file, la suite lit de vraies clés.
    skip: const bool.hasEnvironment('SUPABASE_URL')
        ? 'clés fournies par --dart-define'
        : false,
  );
}
