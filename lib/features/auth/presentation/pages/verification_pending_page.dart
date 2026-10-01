import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

class VerificationPendingPage extends ConsumerWidget {
  const VerificationPendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const SizedBox(height: 12),
              Text(
                switch (ref.watch(kycStateProvider)) {
                  AsyncData(:final value)
                      when value.status == KycStatus.pending =>
                    'Dossier envoyé, en attente de validation.',
                  AsyncData() => 'Aucun dossier envoyé.',
                  AsyncError() => 'Statut indisponible pour le moment.',
                  _ => 'Chargement du statut…',
                },
                style: const TextStyle(
                  color: AppColors.inkSecondary,
                  fontSize: 13,
                ),
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
