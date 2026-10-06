import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/auth_controller.dart';
import 'package:micro_opportunites/features/auth/presentation/controllers/entry_draft_controller.dart';

/// A05 : e-mail et mot de passe, création de compte ou connexion.
/// [onSignedIn] est fourni par l'app : après une connexion, elle décide de
/// la suite selon le rôle du compte.
class EmailPage extends ConsumerStatefulWidget {
  const EmailPage({super.key, required this.onSignedIn});

  final void Function(BuildContext context, Account account) onSignedIn;

  @override
  ConsumerState<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends ConsumerState<EmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _error;

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty) {
      setState(() => _error = 'Saisissez votre e-mail.');
      return;
    }
    if (password.isEmpty) {
      setState(() => _error = 'Saisissez votre mot de passe.');
      return;
    }
    final creating = ref.read(entryDraftControllerProvider).creatingAccount;
    final actions = ref.read(authActionsProvider.notifier);
    final result = creating
        ? await actions.signup(email, password)
        : await actions.login(email, password);
    if (!mounted) return;
    switch (result) {
      case Success(:final value):
        setState(() => _error = null);
        if (creating) {
          context.push(EntryPaths.profile);
        } else if (value.role == null) {
          context.go(EntryPaths.usage);
        } else {
          widget.onSignedIn(context, value);
        }
      case Err(:final failure):
        setState(() => _error = failure.message);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final creating = ref.watch(entryDraftControllerProvider).creatingAccount;
    final loading = ref.watch(authActionsProvider).isLoading;
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
                        'Votre e-mail',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Il sert à vous connecter à votre compte.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        key: const Key('email.field'),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Adresse e-mail',
                          hintText: 'vous@exemple.com',
                        ),
                        onChanged: (_) => setState(() => _error = null),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        key: const Key('password.field'),
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                          hintText: 'Au moins 6 caractères',
                        ),
                        onChanged: (_) => setState(() => _error = null),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          style: const TextStyle(
                            color: AppColors.red,
                            fontSize: 13,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      const Text(
                        'En continuant vous acceptez nos Conditions générales. Il est important que vous les lisiez pour comprendre comment nous gérons vos données.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: loading ? null : _submit,
                        child: Text(
                          creating ? 'Créer mon compte' : 'Me connecter',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() => _error = null);
                          ref
                              .read(entryDraftControllerProvider.notifier)
                              .setCreatingAccount(!creating);
                        },
                        child: Text(
                          creating ? 'J’ai déjà un compte' : 'Créer un compte',
                        ),
                      ),
                    ],
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
