/// Montant entier avec espace fine insécable entre milliers : « 5 000 ».
String formatAmount(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer(amount < 0 ? '-' : '');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('\u202f');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// « 5 000 FCFA » (espace insécable avant la devise).
String formatFcfa(int amount) => '${formatAmount(amount)}\u00a0FCFA';

/// Note sur 5 avec virgule : « 4,8 ».
String formatRating(double rating) =>
    rating.toStringAsFixed(1).replaceAll('.', ',');
