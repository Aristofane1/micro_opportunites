import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/formatting/dates.dart';
import 'package:micro_opportunites/core/formatting/money.dart';

void main() {
  group('montants', () {
    test('séparateur de milliers espace fine insécable', () {
      expect(formatAmount(5000), '5\u202f000');
      expect(formatAmount(125000), '125\u202f000');
      expect(formatAmount(750), '750');
      expect(formatFcfa(7500), '7\u202f500\u00a0FCFA');
    });
    test('note avec virgule décimale', () {
      expect(formatRating(4.8), '4,8');
      expect(formatRating(5), '5,0');
    });
  });

  group('dates (heure du Bénin, UTC+1)', () {
    final now = DateTime.utc(2026, 9, 29, 8); // mardi 29 sept., 9 h au Bénin
    test('jour court et heure', () {
      final start = DateTime.utc(2026, 10, 3, 7); // samedi 3 oct. 8 h
      expect(formatShortDay(start), 'Sam. 3 oct.');
      expect(formatHour(start), '8 h');
      expect(formatHour(DateTime.utc(2026, 10, 3, 6, 56)), '7 h 56');
      expect(formatShortDate(DateTime.utc(2026, 9, 26, 13)), '26 sept.');
    });
    test('jour relatif', () {
      expect(
        formatDayRelative(DateTime.utc(2026, 9, 29, 15), now),
        "Aujourd'hui",
      );
      expect(formatDayRelative(DateTime.utc(2026, 9, 30, 9), now), 'Demain');
      expect(
        formatDayRelative(DateTime.utc(2026, 10, 3, 7), now),
        'Sam. 3 oct.',
      );
    });
    test('durées', () {
      expect(formatDuration(const Duration(hours: 4)), '4 h');
      expect(formatDuration(const Duration(minutes: 90)), '1 h 30');
      expect(formatDuration(const Duration(minutes: 249)), '4 h 09');
      expect(formatDuration(const Duration(minutes: 45)), '45 min');
    });
    test('passé relatif', () {
      expect(
        formatRelativePast(now.subtract(const Duration(seconds: 20)), now),
        "à l'instant",
      );
      expect(
        formatRelativePast(now.subtract(const Duration(minutes: 20)), now),
        'il y a 20 min',
      );
      expect(
        formatRelativePast(now.subtract(const Duration(hours: 3)), now),
        'il y a 3 h',
      );
      expect(formatRelativePast(DateTime.utc(2026, 9, 28, 12), now), 'hier');
      expect(
        formatRelativePast(DateTime.utc(2026, 9, 20, 12), now),
        'Dim. 20 sept.',
      );
    });
    test('date longue et mois', () {
      expect(
        formatLongDateTime(DateTime.utc(2026, 9, 26, 13, 12)),
        '26 sept. 2026 · 14 h 12',
      );
      expect(formatMonthYear(DateTime.utc(2026, 3, 10)), 'mars 2026');
    });
  });
}
