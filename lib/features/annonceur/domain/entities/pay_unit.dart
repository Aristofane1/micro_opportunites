enum PayUnit {
  flat('Forfait'),
  hourly('Par heure'),
  daily('Par jour');

  const PayUnit(this.label);
  final String label;
}
