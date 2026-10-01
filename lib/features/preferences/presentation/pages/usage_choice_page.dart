import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class UsageChoicePage extends StatelessWidget {
  const UsageChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Que voulez-vous faire\nd\'abord ?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Vous pourrez toujours changer d\'avis à tout moment dans l\'application.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 48),
              _buildChoiceCard(
                context,
                title: 'Trouver des missions',
                subtitle: 'C\'est l\'aventure ! Je souhaite chercher des missions près de chez moi.',
                icon: Icons.search,
                onTap: () => context.go('/preferences/permissions'),
              ),
              const SizedBox(height: 24),
              _buildChoiceCard(
                context,
                title: 'Publier une mission',
                subtitle: 'J\'ai besoin d\'aide. Je cherche quelqu\'un pour me rendre service.',
                icon: Icons.add_circle_outline,
                onTap: () => context.go('/preferences/permissions'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: AppTheme.primaryGreen),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
