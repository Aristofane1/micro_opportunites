import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/theme/app_radius.dart';

/// Indicateur d'étapes : [total] segments de 6 px, les [current] premiers en vert.
class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.total, required this.current})
    : assert(total > 0),
      assert(current >= 0 && current <= total);

  final int total;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Étape $current sur $total',
      child: Row(
        children: [
          for (var i = 0; i < total; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: i < current ? AppColors.green : AppColors.lineStrong,
                  borderRadius: AppRadius.pillAll,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
