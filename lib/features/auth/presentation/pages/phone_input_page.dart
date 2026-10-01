import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:micro_opportunites/core/theme/app_theme.dart';

class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/onboarding');
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.security,
                  size: 48,
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(height: 24),
                Text(
                  'Votre numéro de\ntéléphone',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'Pour sécuriser votre compte, nous vous envoyons un SMS de confirmation.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                IntlPhoneField(
                  controller: _phoneController,
                  initialCountryCode: 'FR',
                  languageCode: 'fr',
                  dropdownIconPosition: IconPosition.trailing,
                  flagsButtonPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Numéro de mobile',
                    hintText: '6 12 34 56 78',
                  ),
                  searchText: 'Rechercher un pays...',
                  invalidNumberMessage: 'Numéro de téléphone invalide',
                  onChanged: (phone) {},
                ),
                const SizedBox(height: 16),
                const Text(
                  'En continuant vous acceptez nos Conditions générales. Il est important que vous les lisiez pour comprendre comment nous gérons vos données.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Si l'utilisateur a saisi un numéro ou pour le test/simulation
                    context.push('/auth/otp');
                  },
                  child: const Text('Envoyer le code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
