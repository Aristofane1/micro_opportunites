/// Raccourci de développement : `flutter run --dart-define=START=publish`
/// démarre connecté en annonceur sur le formulaire « Nouvelle mission ».
const _devStart = String.fromEnvironment('START');

bool get startOnPublish => _devStart == 'publish';
