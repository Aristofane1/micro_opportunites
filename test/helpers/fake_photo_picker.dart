import 'dart:io';

import 'package:micro_opportunites/core/media/photo_picker.dart';

/// Appareil photo de test : chaque prise crée un petit fichier temporaire
/// et renvoie son chemin ; `cancel` simule l'annulation par l'utilisateur.
class FakePhotoPicker implements PhotoPicker {
  FakePhotoPicker({this.cancel = false});

  bool cancel;
  final sources = <PhotoSource>[];

  /// Caméra frontale demandée, prise par prise.
  final frontCameras = <bool>[];

  @override
  Future<String?> pick(PhotoSource source, {bool frontCamera = false}) async {
    sources.add(source);
    frontCameras.add(frontCamera);
    if (cancel) return null;
    final dir = Directory.systemTemp.createTempSync('photo_test');
    final file = File('${dir.path}/photo_${sources.length}.jpg')
      ..writeAsBytesSync(const [0xff, 0xd8, 0xff, 0xd9]);
    return file.path;
  }
}
