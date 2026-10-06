/// Raccourci de développement : `flutter run --dart-define=START=publish`
/// démarre directement sur le formulaire « Nouvelle mission » (rôle Annonceur).
/// Sans ce paramètre, l'application démarre normalement sur le splash.
const _devStart = String.fromEnvironment('START');

bool get startOnPublish => _devStart == 'publish';
