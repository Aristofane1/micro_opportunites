import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  DateTime? _selectedBirthDate;
  bool _acceptTerms = false;
  bool _acceptNewsletter = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate =
        _selectedBirthDate ?? DateTime(now.year - 20, now.month, now.day);
    final DateTime firstDate = DateTime(1920);
    final DateTime lastDate = DateTime(now.year - 15, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('fr', 'FR'),
      helpText: 'SÉLECTIONNEZ VOTRE DATE DE NAISSANCE',
      cancelText: 'ANNULER',
      confirmText: 'CONFIRMER',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.green,
              onPrimary: Colors.white,
              onSurface: AppColors.ink,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
              context.go(EntryPaths.otp);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Faisons connaissance',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Ces informations permettront de personnaliser votre expérience et valider votre identité.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _firstNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    hintText: 'Ex: Thomas',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.green,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre prénom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    hintText: 'Ex: Dubois',
                    prefixIcon: Icon(
                      Icons.badge_outlined,
                      color: AppColors.green,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Veuillez saisir votre nom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _birthDateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    labelText: 'Date de naissance',
                    hintText: 'JJ/MM/AAAA',
                    prefixIcon: const Icon(
                      Icons.cake_outlined,
                      color: AppColors.green,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.green,
                      ),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez sélectionner votre date de naissance';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.green,
                  value: _acceptTerms,
                  onChanged: (val) =>
                      setState(() => _acceptTerms = val ?? false),
                  title: const Text(
                    'J\'accepte les Conditions Générales et la Politique de confidentialité.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.green,
                  value: _acceptNewsletter,
                  onChanged: (val) =>
                      setState(() => _acceptNewsletter = val ?? false),
                  title: const Text(
                    'Recevoir les communications par e-mail.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to ID document step
                    context.push(EntryPaths.idDocument);
                  },
                  child: const Text('Continuer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
