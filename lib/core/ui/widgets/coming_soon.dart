import 'package:flutter/widgets.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';

/// Clic vers un écran d'un autre module, pas encore construit.
void showComingSoon(BuildContext context, String feature) =>
    showAppToast(context, '$feature : bientôt disponible');
