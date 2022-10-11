//
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_school/styling/pallet.dart';
import 'package:my_school/widgets/app_title_bar.dart';
import 'package:my_school/widgets/custom_image_cropper.dart';
import 'package:path_provider/path_provider.dart';

import '../../database/school_database.dart';
import 'profile_screen_widgets.dart';

class ProfileScreen extends StatefulWidget {
  final Student student;

  const ProfileScreen({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const AppTitleBar(),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: Pallet.backgroundGradient,
        ),
        child: SingleChildScrollView(child: _body(context)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _imageSection(),
        Container(),
      ],
    );
  }

  Widget _imageSection() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _image(),
        Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.only(right: 8),
          child: Column(
            children: [
              RoundedButton(onPressed: () => _uploadImage(), icon: Icons.edit),
              _pickedFile != null
                  ? RoundedButton(
                      onPressed: () => _cropImage(), icon: Icons.crop)
                  : const SizedBox.shrink(),
              _croppedFile != null
                  ? RoundedButton(
                      onPressed: () => _saveImage(), icon: Icons.save_alt)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _image() {
    final size = MediaQuery.of(context).size;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedImage(
          width: size.width, height: size.height * 0.3, path: path);
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedImage(
          width: size.width,
          height: size.height * 0.3,
          path: path,
          isRound: false);
    } else if (widget.student.imagePath != null) {
      return ConstrainedImage(
          width: size.width,
          height: size.height * 0.3,
          path: widget.student.imagePath!);
    } else {
      return ConstrainedImage(
          width: size.width,
          height: size.height * 0.3,
          path: '',
          isPlaceholder: true);
    }
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await customImageCropper(context, _pickedFile!);
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<bool> _saveImage() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;

    final String newImagePath = '$path/image1.png';

    final bytes = await _croppedFile?.readAsBytes();
    if (bytes != null) {
      final File file = File(newImagePath);
      await file.writeAsBytes(bytes);
      setState(() {
        _pickedFile = XFile(newImagePath);
        _croppedFile = null;
      });
      return true;
    } else {
      return false;
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  // Future<CroppedFile?> _imageCropper() {
  //   return ImageCropper().cropImage(
  //     sourcePath: _pickedFile!.path,
  //     compressFormat: ImageCompressFormat.jpg,
  //     compressQuality: 100,
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //       WebUiSettings(
  //         context: context,
  //         presentStyle: CropperPresentStyle.dialog,
  //         boundary: const CroppieBoundary(
  //           width: 520,
  //           height: 520,
  //         ),
  //         viewPort:
  //             const CroppieViewPort(width: 480, height: 480, type: 'circle'),
  //         enableExif: true,
  //         enableZoom: true,
  //         showZoomer: true,
  //       ),
  //     ],
  //   );
  // }
}
