enum MissionStatus {
  published('Publiée'),
  selected('Candidat sélectionné'),
  inProgress('En cours'),
  completed('Terminée'),
  cancelled('Annulée');

  const MissionStatus(this.label);
  final String label;

  /// Statut renvoyé par l'API (`published`, `inProgress`…).
  static MissionStatus fromApi(String value) =>
      values.asNameMap()[value] ?? MissionStatus.published;

  /// Missions affichées dans l'onglet « Actives »
  bool get isActive =>
      this == published || this == selected || this == inProgress;

  /// Missions affichées dans l'onglet « Terminées »
  bool get isPast => this == completed || this == cancelled;
}
