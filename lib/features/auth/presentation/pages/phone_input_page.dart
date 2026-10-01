import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class PhoneInputPage extends ConsumerStatefulWidget {
  const PhoneInputPage({super.key});

  @override
  ConsumerState<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends ConsumerState<PhoneInputPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _completeNumber = '';
  String? _error;

  Future<void> _send() async {
    if (_completeNumber.replaceAll(RegExp(r'\D'), '').length < 8) {
      setState(() => _error = 'Saisissez votre numéro.');
      return;
    }
    final result = await ref
        .read(authActionsProvider.notifier)
        .requestCode(_completeNumber);
    if (!mounted) return;
    switch (result) {
      case Success():
        context.push(EntryPaths.otp);
      case Err(:final failure):
        setState(() => _error = failure.message);
    }
  }

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
              context.go(EntryPaths.onboarding);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.security,
                          size: 48,
                          color: AppColors.green,
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
                          initialCountryCode: 'BJ',
                          languageCode: 'fr',
                          dropdownIconPosition: IconPosition.trailing,
                          flagsButtonPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Numéro de mobile',
                            hintText: '6 12 34 56 78',
                          ),
                          pickerDialogStyle: PickerDialogStyle(
                            searchFieldInputDecoration: const InputDecoration(
                              labelText: 'Rechercher un pays...',
                            ),
                          ),
                          invalidNumberMessage: 'Numéro de téléphone invalide',
                          onChanged: (phone) => setState(() {
                            _completeNumber = phone.completeNumber;
                            _error = null;
                          }),
                        ),
                        if (_error != null)
                          Text(
                            _error!,
                            style: const TextStyle(
                              color: AppColors.red,
                              fontSize: 13,
                            ),
                          ),
                        const SizedBox(height: 16),
                        const Text(
                          'En continuant vous acceptez nos Conditions générales. Il est important que vous les lisiez pour comprendre comment nous gérons vos données.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: ref.watch(authActionsProvider).isLoading
                              ? null
                              : _send,
                          child: const Text('Envoyer le code'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
