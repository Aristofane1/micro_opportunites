import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:micro_opportunites/core/geo/map_tiles.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';

class EtapeOuScreen extends ConsumerStatefulWidget {
  const EtapeOuScreen({super.key});

  @override
  ConsumerState<EtapeOuScreen> createState() => _EtapeOuScreenState();
}

class _EtapeOuScreenState extends ConsumerState<EtapeOuScreen> {
  // Centre par défaut de la carte (Abomey-Calavi, valeur approximative)
  static const _defaultCenter = LatLng(6.4488, 2.3556);

  late final TextEditingController _cityCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _landmarkCtrl;
  late final LatLng _initialCenter;

  @override
  void initState() {
    super.initState();
    final draft = ref.read(missionDraftControllerProvider);
    _cityCtrl = TextEditingController(text: draft.city ?? '');
    _addressCtrl = TextEditingController(text: draft.address ?? '');
    _landmarkCtrl = TextEditingController(text: draft.landmark ?? '');

    final hasPin = draft.latitude != null && draft.longitude != null;
    _initialCenter = hasPin
        ? LatLng(draft.latitude!, draft.longitude!)
        : _defaultCenter;

    // Si aucune épingle n'a encore été placée, on enregistre la position de départ
    if (!hasPin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref
            .read(missionDraftControllerProvider.notifier)
            .updatePin(_defaultCenter.latitude, _defaultCenter.longitude);
      });
    }
  }

  @override
  void dispose() {
    _cityCtrl.dispose();
    _addressCtrl.dispose();
    _landmarkCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickEntrancePhoto() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;
    ref
        .read(missionDraftControllerProvider.notifier)
        .updateEntrancePhoto(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(missionDraftControllerProvider);
    final controller = ref.read(missionDraftControllerProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    final publicPlace = (draft.city ?? '').trim().isEmpty
        ? 'la ville'
        : draft.city!.trim();

    return Column(
      children: [
        // --- Carte (fixe en haut, pour ne pas gêner le défilement) ---
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 210,
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: _initialCenter,
                      initialZoom: 15,
                      // On enregistre la position quand l'utilisateur déplace la carte
                      onPositionChanged: (camera, hasGesture) {
                        if (!hasGesture) return;
                        controller.updatePin(
                          camera.center.latitude,
                          camera.center.longitude,
                        );
                      },
                    ),
                    children: [
                      if (ref.watch(mapTilesEnabledProvider))
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          // À remplacer par l'applicationId de ton projet Android
                          userAgentPackageName:
                              'com.example.micro_opportunites',
                        ),
                    ],
                  ),
                  // Épingle fixe au centre : c'est la carte qui bouge dessous
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, -20),
                      child: Icon(
                        Icons.location_on,
                        size: 44,
                        color: colors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Déplacez la carte pour placer l\'épingle',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- Formulaire (défile si le clavier prend de la place) ---
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Label('Ville ou quartier (visible par tous)'),
                TextField(
                  controller: _cityCtrl,
                  onChanged: controller.updateCity,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Ex. Abomey-Calavi',
                  ),
                ),
                const SizedBox(height: 16),
                const _Label('Adresse'),
                TextField(
                  controller: _addressCtrl,
                  onChanged: controller.updateAddress,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Ex. Rue de la pharmacie, Godomey',
                  ),
                ),
                const SizedBox(height: 16),
                const _Label('Point de repère'),
                TextField(
                  controller: _landmarkCtrl,
                  onChanged: controller.updateLandmark,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Ex. Face à la station du carrefour',
                  ),
                ),
                const SizedBox(height: 16),

                // --- Photo de l'entrée ---
                if (draft.entrancePhotoPath == null)
                  OutlinedButton(
                    onPressed: _pickEntrancePhoto,
                    child: const Text('+ Photo de l\'entrée'),
                  )
                else
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(draft.entrancePhotoPath!),
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () => controller.updateEntrancePhoto(null),
                        child: const Text('Retirer la photo'),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),

                // --- Message de confidentialité ---
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: colors.onSecondaryContainer,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Le public ne verra que '),
                              TextSpan(
                                text: publicPlace,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    '. L\'adresse s\'affiche seulement aux '
                                    'personnes que vous retenez.',
                              ),
                            ],
                          ),
                          style: TextStyle(color: colors.onSecondaryContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );
}
