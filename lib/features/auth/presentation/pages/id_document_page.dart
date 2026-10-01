import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:country_picker/country_picker.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';

class IdDocumentPage extends StatefulWidget {
  const IdDocumentPage({super.key});

  @override
  State<IdDocumentPage> createState() => _IdDocumentPageState();
}

class _IdDocumentPageState extends State<IdDocumentPage> {
  String _selectedDocument = 'id_card';
  Country _selectedCountry = Country(
    phoneCode: '33',
    countryCode: 'FR',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'France',
    example: '612345678',
    displayName: 'France (FR) [+33]',
    displayNameNoCountryCode: 'France (FR)',
    e164Key: '',
  );

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Rechercher un pays',
          hintText: 'Ex: France, Belgique, Sénégal...',
          prefixIcon: const Icon(Icons.search, color: AppColors.green),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
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
              context.go(EntryPaths.profile);
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
                'Votre pièce d\'identité',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'C\'est une obligation légale pour assurer la sécurité de tous. Personne ne la verra.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _showCountryPicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedCountry.flagEmoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pays d\'émission',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.inkSecondary,
                              ),
                            ),
                            Text(
                              _selectedCountry.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.ink,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: AppColors.green),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildDocumentOption(
                title: 'Carte d\'identité (format carte)',
                value: 'id_card',
              ),
              const SizedBox(height: 16),
              _buildDocumentOption(title: 'Passeport', value: 'passport'),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.push(EntryPaths.cameraFront),
                child: const Text('Photographier le recto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentOption({required String title, required String value}) {
    final isSelected = _selectedDocument == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedDocument = value),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.green.withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.green : Colors.grey.shade400,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.green : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
