import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

class VerificationPendingPage extends StatelessWidget {
  const VerificationPendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.green.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 50,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Vérification en cours',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Vos documents sont en cours de traitement.\nVous pouvez déjà explorer l\'application.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const CircularProgressIndicator(color: AppColors.green),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go(EntryPaths.usage),
                child: const Text('Trouver des missions'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
