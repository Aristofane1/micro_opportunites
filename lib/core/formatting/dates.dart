const _weekdays = ['Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.', 'Dim.'];
const _monthsShort = [
  'janv.',
  'févr.',
  'mars',
  'avr.',
  'mai',
  'juin',
  'juil.',
  'août',
  'sept.',
  'oct.',
  'nov.',
  'déc.',
];
const _monthsLong = [
  'janvier',
  'février',
  'mars',
  'avril',
  'mai',
  'juin',
  'juillet',
  'août',
  'septembre',
  'octobre',
  'novembre',
  'décembre',
];

/// Heure du Bénin (UTC+1, pas d'heure d'été), exprimée en DateTime UTC
/// dont les champs se lisent comme l'heure locale béninoise.
DateTime toBeninTime(DateTime instant) =>
    instant.toUtc().add(const Duration(hours: 1));

DateTime _beninDay(DateTime instant) {
  final local = toBeninTime(instant);
  return DateTime.utc(local.year, local.month, local.day);
}

String _two(int value) => value.toString().padLeft(2, '0');

/// « Sam. 4 oct. »
String formatShortDay(DateTime instant) {
  final local = toBeninTime(instant);
  return '${_weekdays[local.weekday - 1]} ${local.day} '
      '${_monthsShort[local.month - 1]}';
}

/// « 26 sept. »
String formatShortDate(DateTime instant) {
  final local = toBeninTime(instant);
  return '${local.day} ${_monthsShort[local.month - 1]}';
}

/// « Aujourd'hui », « Demain » ou « Sam. 4 oct. »
String formatDayRelative(DateTime instant, DateTime now) {
  final days = _beninDay(instant).difference(_beninDay(now)).inDays;
  if (days == 0) return "Aujourd'hui";
  if (days == 1) return 'Demain';
  return formatShortDay(instant);
}

/// « 8 h » ou « 7 h 56 »
String formatHour(DateTime instant) {
  final local = toBeninTime(instant);
  return local.minute == 0
      ? '${local.hour} h'
      : '${local.hour} h ${_two(local.minute)}';
}

/// « 4 h », « 1 h 30 », « 4 h 09 », « 45 min »
String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  if (hours == 0) return '$minutes min';
  if (minutes == 0) return '$hours h';
  return '$hours h ${_two(minutes)}';
}

/// « à l'instant », « il y a 20 min », « il y a 3 h », « hier », sinon jour court.
String formatRelativePast(DateTime instant, DateTime now) {
  final elapsed = now.difference(instant);
  if (elapsed.inMinutes < 1) return "à l'instant";
  if (elapsed.inMinutes < 60) return 'il y a ${elapsed.inMinutes} min';
  final days = _beninDay(now).difference(_beninDay(instant)).inDays;
  if (days == 0) return 'il y a ${elapsed.inHours} h';
  if (days == 1) return 'hier';
  return formatShortDay(instant);
}

/// « 26 sept. 2026 · 14 h 12 »
String formatLongDateTime(DateTime instant) {
  final local = toBeninTime(instant);
  return '${formatShortDate(instant)} ${local.year} · ${formatHour(instant)}';
}

/// « mars 2026 »
String formatMonthYear(DateTime instant) {
  final local = toBeninTime(instant);
  return '${_monthsLong[local.month - 1]} ${local.year}';
}
