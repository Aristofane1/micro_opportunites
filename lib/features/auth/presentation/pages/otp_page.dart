import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:micro_opportunites/core/ui/widgets/app_toast.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

import 'package:micro_opportunites/core/theme/app_colors.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  String? _error;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _verify() async {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 5) {
      setState(() => _error = 'Saisissez les 5 chiffres.');
      return;
    }
    final result = await ref
        .read(authActionsProvider.notifier)
        .verifyCode(code);
    if (!mounted) return;
    switch (result) {
      case Success():
        context.push(EntryPaths.profile);
      case Err(:final failure):
        setState(() => _error = failure.message);
    }
  }

  Future<void> _resend(String phone) async {
    final result = await ref
        .read(authActionsProvider.notifier)
        .requestCode(phone);
    if (!mounted) return;
    if (result case Success()) showAppToast(context, 'Nouveau code envoyé');
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(entryDraftControllerProvider);
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
              context.go(EntryPaths.phone);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entrez le code reçu',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Envoyé par SMS au ${draft.verification?.maskedPhone ?? ''}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(EntryPaths.phone);
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  'Modifier',
                  style: TextStyle(
                    color: AppColors.green,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                'Code de démonstration : ${draft.verification?.demoCode ?? ''}',
                style: const TextStyle(
                  color: AppColors.ochreDeep,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      key: Key('otp.digit.$index'),
                      controller: _controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.length == 1 && index < 4) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: const TextStyle(color: AppColors.red, fontSize: 13),
                ),
              ],
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () => _resend(draft.phone ?? ''),
                  child: const Text(
                    'Je n\'ai pas reçu le code',
                    style: TextStyle(color: AppColors.inkSecondary),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: ref.watch(authActionsProvider).isLoading
                    ? null
                    : _verify,
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
