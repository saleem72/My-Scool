//

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<CroppedFile?> customImageCropper(BuildContext context, XFile source) {
  return ImageCropper().cropImage(
    sourcePath: source.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.dialog,
        boundary: const CroppieBoundary(
          width: 520,
          height: 520,
        ),
        viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
      ),
    ],
  );
}
