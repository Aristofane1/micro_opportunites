import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_picker.g.dart';

enum PhotoSource { camera, gallery }

/// Choix d'une photo ; renvoie le chemin local ou `null` si annulé.
/// [frontCamera] demande la caméra frontale (selfie).
abstract interface class PhotoPicker {
  Future<String?> pick(PhotoSource source, {bool frontCamera = false});
}

class ImagePickerPhotoPicker implements PhotoPicker {
  ImagePickerPhotoPicker([ImagePicker? picker])
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<String?> pick(PhotoSource source, {bool frontCamera = false}) async {
    final file = await _picker.pickImage(
      source: source == PhotoSource.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 80,
      preferredCameraDevice: frontCamera
          ? CameraDevice.front
          : CameraDevice.rear,
    );
    return file?.path;
  }
}

@Riverpod(keepAlive: true)
PhotoPicker photoPicker(Ref ref) => ImagePickerPhotoPicker();
