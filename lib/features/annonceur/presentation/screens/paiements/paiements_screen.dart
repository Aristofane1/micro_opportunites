import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:micro_opportunites/features/annonceur/domain/entities/payment_entry.dart';
import 'package:micro_opportunites/features/annonceur/presentation/controllers/annonceur_providers.dart';
import 'package:micro_opportunites/features/annonceur/presentation/utils/formatters.dart';

enum _Filter {
  all('Tout'),
  blocked('Bloqués'),
  paid('Versés'),
  refunded('Remboursés');

  const _Filter(this.label);
  final String label;
}

class PaiementsScreen extends ConsumerStatefulWidget {
  const PaiementsScreen({super.key});

  @override
  ConsumerState<PaiementsScreen> createState() => _PaiementsScreenState();
}

class _PaiementsScreenState extends ConsumerState<PaiementsScreen> {
  static const _green = Color(0xFF1F6B4F);

  _Filter _filter = _Filter.all;

  (String, Color) _subtitle(PaymentEntry r, ColorScheme colors) =>
      switch (r.kind) {
        PaymentKind.blocked => (
          'Bloqué · payé le ${formatShortDate(r.date)}',
          colors.primary,
        ),
        PaymentKind.paid => (
          '${r.detail} · ${formatShortDate(r.date)}',
          colors.onSurfaceVariant,
        ),
        PaymentKind.refunded => (r.detail, _green),
      };

  (String, Color) _amount(PaymentEntry r, ColorScheme colors) =>
      switch (r.kind) {
        PaymentKind.blocked => (groupThousands(r.amount), colors.primary),
        PaymentKind.paid => ('− ${groupThousands(r.amount)}', colors.onSurface),
        PaymentKind.refunded => ('+ ${groupThousands(r.amount)}', _green),
      };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final rows = ref.watch(paymentRowsProvider);
    final now = DateTime.now();

    // --- Les deux totaux du haut ---
    final blockedRows = rows
        .where((r) => r.kind == PaymentKind.blocked)
        .toList();
    final blockedTotal = blockedRows.fold<int>(0, (s, r) => s + r.amount);

    final paidRows = rows
        .where(
          (r) =>
              r.kind == PaymentKind.paid &&
              r.date.year == now.year &&
              r.date.month == now.month,
        )
        .toList();
    final paidTotal = paidRows.fold<int>(0, (s, r) => s + r.amount);
    final paidPeople = paidRows.fold<int>(0, (s, r) => s + r.people);
    final month = DateFormat('MMMM', 'fr').format(now);

    // --- La liste filtrée ---
    final shown = switch (_filter) {
      _Filter.all => rows,
      _Filter.blocked => blockedRows,
      _Filter.paid => rows.where((r) => r.kind == PaymentKind.paid).toList(),
      _Filter.refunded =>
        rows.where((r) => r.kind == PaymentKind.refunded).toList(),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const Text(
          'Paiements',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),

        // --- Totaux ---
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bloqué en ce moment',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      groupThousands(blockedTotal),
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'FCFA · ${blockedRows.length} mission${blockedRows.length > 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border.all(color: colors.outlineVariant),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Versé en $month',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      groupThousands(paidTotal),
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'FCFA · $paidPeople personne${paidPeople > 1 ? 's' : ''}',
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // --- Filtres ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final f in _Filter.values) ...[
                _FilterChip(
                  label: f.label,
                  selected: _filter == f,
                  onTap: () => setState(() => _filter = f),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // --- Opérations ---
        if (shown.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: Text('Aucune opération.')),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.outlineVariant),
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (var i = 0; i < shown.length; i++) ...[
                  if (i > 0) const Divider(height: 1),
                  _buildRow(shown[i], colors),
                ],
              ],
            ),
          ),
        const SizedBox(height: 16),

        // --- Moyen de paiement ---
        Material(
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colors.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Bientôt disponible'))),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Moyen de paiement',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        // le numéro masqué viendra du profil de l'utilisateur
                        Text(
                          'MTN MoMo',
                          style: TextStyle(color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(PaymentEntry r, ColorScheme colors) {
    final (subtitle, subtitleColor) = _subtitle(r, colors);
    final (amountText, amountColor) = _amount(r, colors);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.5, color: subtitleColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            amountText,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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
