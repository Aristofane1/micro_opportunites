/// Profil actif. Change la navigation, jamais les droits (le serveur décide).
enum ActiveRole {
  worker(label: 'Exécutant'),
  poster(label: 'Annonceur');

  const ActiveRole({required this.label});

  final String label;

  ActiveRole get other => this == worker ? poster : worker;
}
