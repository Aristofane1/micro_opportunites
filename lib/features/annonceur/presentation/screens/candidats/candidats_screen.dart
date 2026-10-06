import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/core/routing/poster_paths.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/candidate.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/candidates_controller.dart';
import 'package:micro_opportunites/features/annonceur/presentation/widgets/candidate_card.dart';

enum _Sort {
  rating('Mieux notés'),
  experience('Plus expérimentés');

  const _Sort(this.label);
  final String label;
}

class CandidatsScreen extends ConsumerStatefulWidget {
  const CandidatsScreen({super.key, required this.missionId});

  final String missionId;

  @override
  ConsumerState<CandidatsScreen> createState() => _CandidatsScreenState();
}

class _CandidatsScreenState extends ConsumerState<CandidatsScreen> {
  bool _showRetained = false; // onglet « Retenus » ou « En attente »
  _Sort _sort = _Sort.rating;

  CandidatesController get _controller =>
      ref.read(candidatesControllerProvider.notifier);

  void _retain(Candidate c) {
    final ok = _controller.retain(widget.missionId, c.id);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Toutes les places sont déjà prises.')),
      );
    }
  }

  List<Candidate> _sorted(List<Candidate> list) {
    final sorted = [...list];
    switch (_sort) {
      case _Sort.rating:
        sorted.sort((a, b) => (b.rating ?? -1).compareTo(a.rating ?? -1));
      case _Sort.experience:
        sorted.sort((a, b) => b.missionsCount.compareTo(a.missionsCount));
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final mission = ref
        .watch(missionsWithCountsProvider)
        .where((m) => m.id == widget.missionId)
        .firstOrNull;
    final all = ref.watch(
      candidatesControllerProvider.select(
        (m) => m[widget.missionId] ?? const <Candidate>[],
      ),
    );

    if (mission == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Mission introuvable.')),
      );
    }

    final pending = all
        .where((c) => c.status == CandidateStatus.pending)
        .toList();
    final retained = all
        .where(
          (c) =>
              c.status == CandidateStatus.retained ||
              c.status == CandidateStatus.confirmed,
        )
        .toList();
    final items = _showRetained ? retained : _sorted(pending);
    final free = mission.slotsFree;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- En-tête ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  IconButton.outlined(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${mission.title} · $free place${free > 1 ? 's' : ''} libre${free > 1 ? 's' : ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                        const Text(
                          'Candidats',
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Filtres ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _FilterPill(
                    label: 'En attente (${pending.length})',
                    selected: !_showRetained,
                    onTap: () => setState(() => _showRetained = false),
                  ),
                  const SizedBox(width: 8),
                  _FilterPill(
                    label: 'Retenus (${retained.length})',
                    selected: _showRetained,
                    onTap: () => setState(() => _showRetained = true),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton<_Sort>(
                    onSelected: (value) => setState(() => _sort = value),
                    itemBuilder: (_) => [
                      for (final s in _Sort.values)
                        PopupMenuItem(value: s, child: Text(s.label)),
                    ],
                    child: const _FilterPill(label: 'Trier ▾', selected: false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // --- Liste ---
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        _showRetained
                            ? 'Personne n\'est encore retenu.'
                            : 'Aucun candidat en attente.',
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      children: [
                        for (final c in items)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: CandidateCard(
                              candidate: c,
                              onTap: () => context.push(
                                PosterPaths.candidate(widget.missionId, c.id),
                              ),
                              onRefuse: () =>
                                  _controller.refuse(widget.missionId, c.id),
                              onRetain: _showRetained ? null : () => _retain(c),
                              statusLabel: _showRetained
                                  ? (c.status == CandidateStatus.confirmed
                                        ? 'Confirmé'
                                        : 'Retenu · 12 h pour confirmer')
                                  : null,
                            ),
                          ),
                        Text(
                          'Une personne retenue a 12 h pour confirmer. Sans '
                          'réponse, la place revient aux autres candidats.',
                          style: TextStyle(
                            fontSize: 13,
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pastille de filtre (sélectionnée = fond sombre)
class _FilterPill extends StatelessWidget {
  const _FilterPill({required this.label, required this.selected, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? colors.onSurface : colors.surface,
          border: Border.all(
            color: selected ? colors.onSurface : colors.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? colors.surface : colors.onSurface,
          ),
        ),
      ),
    );
  }
}
