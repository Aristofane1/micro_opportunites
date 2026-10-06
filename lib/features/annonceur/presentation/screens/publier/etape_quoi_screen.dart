import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/mission_draft_controller.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/category_chip.dart';

class EtapeQuoiScreen extends ConsumerStatefulWidget {
  const EtapeQuoiScreen({super.key});

  @override
  ConsumerState<EtapeQuoiScreen> createState() => _EtapeQuoiScreenState();
}

class _EtapeQuoiScreenState extends ConsumerState<EtapeQuoiScreen> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    // On remplit les champs avec le brouillon existant (utile si on revient en arrière)
    final draft = ref.read(missionDraftControllerProvider);
    _titleCtrl = TextEditingController(text: draft.title ?? '');
    _descCtrl = TextEditingController(text: draft.description ?? '');
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null || !mounted) return;
    ref.read(missionDraftControllerProvider.notifier).addPhoto(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(missionDraftControllerProvider);
    final controller = ref.read(missionDraftControllerProvider.notifier);
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Titre ---
          const _Label('Titre'),
          TextField(
            controller: _titleCtrl,
            onChanged: controller.updateTitle,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'Ex. Distribution de flyers au carrefour',
            ),
          ),
          const SizedBox(height: 20),

          // --- Catégorie ---
          const _Label('Catégorie'),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.95,
            children: [
              for (final category in publishableCategories)
                CategoryTile(
                  category: category,
                  selected: draft.category == category,
                  onTap: () => controller.updateCategory(category),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // --- Description ---
          const _Label('Description'),
          TextField(
            controller: _descCtrl,
            onChanged: controller.updateDescription,
            minLines: 4,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText:
                  'Décris la mission : ce qu\'il y a à faire, le matériel fourni…',
            ),
          ),
          const SizedBox(height: 20),

          // --- Photos ---
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final path in draft.photoPaths)
                _PhotoThumb(
                  path: path,
                  onRemove: () => controller.removePhoto(path),
                ),
              if (draft.photoPaths.length < 3)
                InkWell(
                  onTap: _pickPhoto,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 72,
                    height: 72,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.outline),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '+ Photo',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Jusqu\'à 3 photos, sans visage ni adresse visible.',
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// Petit titre au-dessus d'un champ
class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );
}

// Une case de catégorie (sélectionnée = fond coloré + bordure principale)
class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected ? colors.primaryContainer : null,
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_outline, color: selected ? colors.primary : null),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// Miniature d'une photo avec une croix pour la retirer
class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({required this.path, required this.onRemove});
  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(path),
            width: 72,
            height: 72,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: const CircleAvatar(
              radius: 10,
              child: Icon(Icons.close, size: 12),
            ),
          ),
        ),
      ],
    );
  }
}
