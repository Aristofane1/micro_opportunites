import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

/// Issue de la reprise au lancement.
sealed class SplashOutcome {
  const SplashOutcome();
}

/// Ouvrir [path].
final class SplashGo extends SplashOutcome {
  const SplashGo(this.path);

  final String path;
}

/// Rester sur le splash : afficher [message] et proposer « Réessayer ».
final class SplashRetry extends SplashOutcome {
  const SplashRetry(this.message);

  final String message;
}

/// A01. Reste affiché au moins deux secondes, le temps que [resolveNext]
/// indique où reprendre ; sans lui, mène à l'onboarding. Au-delà de deux
/// secondes, un indicateur de chargement apparaît sous le logo. En cas
/// d'échec, « Réessayer » et, si [onSignOut] est fourni, « Se déconnecter ».
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.resolveNext, this.onSignOut});

  final Future<SplashOutcome> Function()? resolveNext;

  /// Sortie de secours quand la reprise échoue : déconnexion locale.
  final Future<void> Function()? onSignOut;

  static const minimumDuration = Duration(seconds: 2);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<SplashOutcome> _resolve() =>
      widget.resolveNext?.call() ??
      Future.value(const SplashGo(EntryPaths.onboarding));

  Future<void> _start() async {
    var done = false;
    final pending = _resolve().whenComplete(() => done = true);
    await Future<void>.delayed(SplashScreen.minimumDuration);
    if (!mounted) return;
    if (!done) setState(() => _loading = true);
    _handle(await pending);
  }

  Future<void> _retry() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    final outcome = await _resolve();
    if (mounted) _handle(outcome);
  }

  void _handle(SplashOutcome outcome) {
    if (!mounted) return;
    switch (outcome) {
      case SplashGo(:final path):
        context.go(path);
      case SplashRetry(:final message):
        setState(() {
          _loading = false;
          _error = message;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 80),
            const SizedBox(height: 24),
            Text(
              'MicroOpportunités',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Des missions de chez vous,\npayées en toute sécurité',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            if (_loading) ...[
              const SizedBox(height: 32),
              const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  key: Key('splash.loading'),
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              ),
            ],
            if (_error case final error?) ...[
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _retry,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Réessayer'),
              ),
              if (widget.onSignOut case final signOut?) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: signOut,
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('Se déconnecter'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
