enum MissionCategory {
  event('event', 'Événement'),
  delivery('delivery', 'Livraison'),
  shopping('shopping', 'Courses'),
  computer('computer', 'Informatique'),
  dataEntry('data_entry', 'Saisie de données'),
  cleaning('cleaning', 'Nettoyage'),
  repair('repair', 'Réparation'),
  flyers('flyers', 'Flyers'),
  other('other', 'Autre');

  const MissionCategory(this.apiValue, this.label);

  /// Valeur échangée avec l'API.
  final String apiValue;
  final String label;

  static MissionCategory fromApi(String value) =>
      values.firstWhere((c) => c.apiValue == value, orElse: () => other);
}
