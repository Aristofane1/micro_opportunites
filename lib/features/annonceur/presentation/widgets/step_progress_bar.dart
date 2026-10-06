import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  const StepProgressBar({super.key, required this.current, this.total = 3});

  final int current; // étape actuelle (0 à total - 1)
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < total; i++)
          Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: i < total - 1 ? 8 : 0),
              decoration: BoxDecoration(
                color: i <= current ? colors.primary : colors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
      ],
    );
  }
}
