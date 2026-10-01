import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';

/// Champ du design : libellé au-dessus (14/600), 48 px, arrondi 10,
/// bordure verte 2 px au focus, rouge 2 px + message en erreur.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.label),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            enabled: enabled,
            maxLines: maxLines,
            maxLength: maxLength,
            buildCounter: maxLength == null
                ? null
                : (
                    _, {
                    required currentLength,
                    required isFocused,
                    maxLength,
                  }) => Text(
                    '$currentLength / $maxLength',
                    style: AppTypography.small.copyWith(
                      color: AppColors.inkSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            style: AppTypography.body,
            decoration: InputDecoration(hintText: hint, errorText: errorText),
          ),
        ],
      ),
    );
  }
}
