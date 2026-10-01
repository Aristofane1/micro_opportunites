import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/error/failure.dart';
import 'package:micro_opportunites/core/ui/widgets/state_views.dart';

/// Affiche chargement / erreur (avec « Réessayer ») / données.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: !value.hasError,
      data: data,
      loading: () => const LoadingView(),
      error: (error, _) => ErrorView(
        message: error is Failure
            ? error.message
            : const UnknownFailure().message,
        onRetry: onRetry,
      ),
    );
  }
}
