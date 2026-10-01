import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(EntryPaths.onboarding);
      }
    });
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
          ],
        ),
      ),
    );
  }
}
