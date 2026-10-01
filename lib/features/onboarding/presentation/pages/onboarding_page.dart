import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Des petites missions,\nprès de chez vous',
      'subtitle': 'Livraison, courses, dépannage, baby-sitting...\nTrouvez des missions en quelques minutes près de vous.',
      'icon': Icons.map_outlined,
    },
    {
      'title': 'Un paiement garanti\navant même de partir',
      'subtitle': 'L\'argent de la mission est bloqué dès la réservation. Il vous est viré sitôt la mission validée.',
      'icon': Icons.shield_outlined,
    },
    {
      'title': 'Tout le monde est\nvérifié',
      'subtitle': 'Chaque compte est formellement vérifié avec pièce d\'identité. Aucune surprise.',
      'icon': Icons.verified_user_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => context.go('/auth/phone'),
                  child: const Text('Passer'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primaryGreen.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            _pages[index]['icon'] as IconData,
                            size: 80,
                            color: AppTheme.accentGold,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          _pages[index]['title']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _pages[index]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? AppTheme.primaryGreen
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_currentIndex < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.go('/auth/phone');
                  }
                },
                child: Text(
                  _currentIndex == _pages.length - 1 ? 'Commencer' : 'Suivant',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
