import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/theme/app_typography.dart';
import 'package:micro_opportunites/features/account/presentation/controllers/current_user_controller.dart';

/// « Bonjour Rodrigue » (B01). Composé dans Explorer par `app/`.
class GreetingText extends ConsumerWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(currentUserProvider).value?.firstName;
    return Text(
      firstName == null ? 'Bonjour' : 'Bonjour $firstName',
      style: AppTypography.caption,
    );
  }
}
