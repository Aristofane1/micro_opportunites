import 'package:flutter/services.dart';
import 'package:micro_opportunites/core/formatting/money.dart';

/// Ajoute les espaces pendant la frappe : 5000 -> « 5 000 »
class ThousandsInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return const TextEditingValue();
    if (digits.length > 9) digits = digits.substring(0, 9);
    final text = formatAmount(int.parse(digits));
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
