enum MissionStatus {
  draft('Brouillon'),
  published('Publiée'),
  selected('Candidat sélectionné'),
  inProgress('En cours'),
  completed('Terminée'),
  cancelled('Annulée');

  const MissionStatus(this.label);
  final String label;

  /// Missions affichées dans l'onglet « Actives »
  bool get isActive =>
      this == published || this == selected || this == inProgress;

  /// Missions affichées dans l'onglet « Passées »
  bool get isPast => this == completed || this == cancelled;
}
