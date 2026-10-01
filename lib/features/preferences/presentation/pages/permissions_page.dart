import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deux autorisations\nutiles',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Pour un meilleur usage, nous avons besoin de votre permission.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              _buildPermissionItem(
                icon: Icons.location_on_outlined,
                title: 'Position',
                description:
                    'Pour vous afficher les missions à proximité de chez vous.',
              ),
              const SizedBox(height: 32),
              _buildPermissionItem(
                icon: Icons.notifications_none_outlined,
                title: 'Notifications',
                description:
                    'Pour vous avertir quand une mission est validée ou d\'un nouveau message.',
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Finaliser l'onboarding et aller à l'accueil
                  // context.go('/home'); // à implémenter
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Félicitations'),
                      content: const Text(
                        'Le flux d\'inscription est terminé. Bienvenue sur MicroOpportunités !',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.go('/');
                          },
                          child: const Text('Recommencer'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('C\'est parti'),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Plus tard',
                    style: TextStyle(color: AppColors.inkSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.green),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.inkSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
