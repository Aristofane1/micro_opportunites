import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/core/assets/app_images.dart';
import 'package:micro_opportunites/core/theme/app_colors.dart';
import 'package:micro_opportunites/core/ui/widgets/app_button.dart';
import 'package:micro_opportunites/core/ui/widgets/app_icon.dart';
import 'package:micro_opportunites/core/ui/widgets/app_logo.dart';
import 'package:micro_opportunites/core/ui/widgets/app_text_field.dart';

import '../../../helpers/pump_app.dart';

String _assetOf(WidgetTester tester) {
  final picture = tester.widget<SvgPicture>(find.byType(SvgPicture).first);
  return (picture.bytesLoader as SvgAssetLoader).assetName;
}

void main() {
  group('AppIcon', () {
    testWidgets('prend la couleur du IconTheme par défaut', (tester) async {
      await tester.pumpThemed(
        const IconTheme(
          data: IconThemeData(color: AppColors.green, size: 30),
          child: AppIcon(AppIcons.explore),
        ),
      );
      final picture = tester.widget<SvgPicture>(find.byType(SvgPicture));
      expect(
        picture.colorFilter,
        const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
      );
      expect(picture.width, 30);
      expect(_assetOf(tester), AppIcons.explore.path);
    });

    testWidgets('expose un libellé pour lecteur d’écran', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpThemed(
        const AppIcon(AppIcons.back, semanticLabel: 'Retour'),
      );
      expect(find.bySemanticsLabel('Retour'), findsOneWidget);
      handle.dispose();
    });
  });

  group('AppLogo', () {
    testWidgets('horizontal : mark + mot-symbole', (tester) async {
      await tester.pumpThemed(const AppLogo());
      expect(
        find.textContaining('Opportunités', findRichText: true),
        findsOneWidget,
      );
      expect(_assetOf(tester), AppImages.logoMark);
    });

    testWidgets('sous 48 px, la flèche disparaît', (tester) async {
      await tester.pumpThemed(
        const AppLogo(variant: AppLogoVariant.mark, size: 32),
      );
      expect(_assetOf(tester), AppImages.logoMarkSmall);
    });

    testWidgets('version courte « MicroOp »', (tester) async {
      await tester.pumpThemed(
        const AppLogo(variant: AppLogoVariant.short, size: 40),
      );
      expect(find.textContaining('Op', findRichText: true), findsOneWidget);
      expect(
        find.textContaining('Opportunités', findRichText: true),
        findsNothing,
      );
    });
  });

  group('AppButton', () {
    testWidgets('appelle onPressed', (tester) async {
      var taps = 0;
      await tester.pumpThemed(
        AppButton(label: 'Postuler', onPressed: () => taps++),
      );
      await tester.tap(find.text('Postuler'));
      expect(taps, 1);
    });

    testWidgets('désactivé quand onPressed est null', (tester) async {
      await tester.pumpThemed(const AppButton(label: 'Payer', onPressed: null));
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });

    testWidgets('Review focus : en chargement, un appui est ignoré', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpThemed(
        AppButton(label: 'Payer', onPressed: () => taps++, isLoading: true),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.tap(find.byType(FilledButton));
      expect(taps, 0);
    });

    testWidgets('variante argent en ocre profond', (tester) async {
      await tester.pumpThemed(
        AppButton(
          label: 'Payer 25 000 FCFA',
          variant: AppButtonVariant.money,
          onPressed: () {},
        ),
      );
      final style = tester
          .widget<FilledButton>(find.byType(FilledButton))
          .style!;
      expect(style.backgroundColor!.resolve({}), AppColors.ochreDeep);
    });

    testWidgets('secondaire et destructif sont des boutons à contour', (
      tester,
    ) async {
      await tester.pumpThemed(
        Column(
          children: [
            AppButton(
              label: 'Secondaire',
              variant: AppButtonVariant.secondary,
              onPressed: () {},
            ),
            AppButton(
              label: 'Supprimer',
              variant: AppButtonVariant.destructive,
              onPressed: () {},
            ),
          ],
        ),
      );
      expect(find.byType(OutlinedButton), findsNWidgets(2));
    });

    testWidgets('Review focus : libellé long + texte ×2 sans débordement', (
      tester,
    ) async {
      await tester.pumpThemed(
        AppButton(
          label: 'Confirmer ma disponibilité pour cette mission',
          icon: AppIcons.check,
          onPressed: () {},
        ),
        size: const Size(320, 640),
        textScale: 2,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('AppTextField', () {
    testWidgets('affiche libellé et erreur, remonte la saisie', (tester) async {
      String? typed;
      await tester.pumpThemed(
        AppTextField(
          label: 'Numéro Mobile Money',
          errorText: 'Numéro incomplet : 10 chiffres attendus.',
          onChanged: (value) => typed = value,
        ),
      );
      expect(find.text('Numéro Mobile Money'), findsOneWidget);
      expect(
        find.text('Numéro incomplet : 10 chiffres attendus.'),
        findsOneWidget,
      );
      await tester.enterText(find.byType(TextField), '0197');
      expect(typed, '0197');
    });
  });
}
