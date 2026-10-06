import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/mission_draft.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/pay_unit.dart';

/// 25000 -> "25 000"
String groupThousands(num value) {
  final digits = value.round().abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// 25000 -> "25 000 FCFA"
String formatFcfa(num value) => '${groupThousands(value)} FCFA';

/// "Sam. 4 oct."
String formatDay(DateTime date) {
  final text = DateFormat('EEE d MMM', 'fr').format(date);
  return text[0].toUpperCase() + text.substring(1);
}

String formatClock(DateTime date) => DateFormat('HH:mm').format(date);

String formatHour(DateTime date) => date.minute == 0
    ? '${date.hour} h'
    : '${date.hour} h ${date.minute.toString().padLeft(2, '0')}';

String formatDuration(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (h == 0) return '$m min';
  return m == 0 ? '$h h' : '$h h ${m.toString().padLeft(2, '0')}';
}

/// Ajoute les espaces pendant la frappe : 5000 -> "5 000"
class ThousandsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return const TextEditingValue();
    if (digits.length > 9) digits = digits.substring(0, 9);
    final text = groupThousands(int.parse(digits));
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// "lundi 6 oct."
String formatDayLong(DateTime date) =>
    DateFormat('EEEE d MMM', 'fr').format(date);

/// 4.9 -> "4,9"
String formatRating(double value) =>
    value.toStringAsFixed(1).replaceAll('.', ',');

/// "5 000 FCFA / pers." (ou "/ h", "/ jour" selon l'unité choisie)
String formatPayPerUnit(MissionDraft d) {
  final suffix = switch (d.payUnit) {
    PayUnit.flat => 'pers.',
    PayUnit.hourly => 'h',
    PayUnit.daily => 'jour',
  };
  return '${formatFcfa(d.payAmount ?? 0)} / $suffix';
}

/// "27 sept."
String formatShortDate(DateTime date) => DateFormat('d MMM', 'fr').format(date);
