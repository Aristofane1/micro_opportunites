import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:micro_opportunites/core/media/photo_picker.dart';

/// Enregistre la caméra demandée à image_picker.
class _RecordingImagePicker extends ImagePicker {
  final devices = <CameraDevice>[];

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    devices.add(preferredCameraDevice);
    return XFile('/tmp/photo.jpg');
  }
}

void main() {
  test('caméra arrière par défaut, frontale sur demande', () async {
    final picker = _RecordingImagePicker();
    final photos = ImagePickerPhotoPicker(picker);
    await photos.pick(PhotoSource.camera);
    await photos.pick(PhotoSource.camera, frontCamera: true);
    expect(picker.devices, [CameraDevice.rear, CameraDevice.front]);
  });
}
