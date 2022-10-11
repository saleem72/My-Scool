//

import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_school/blocs/cubit/school_database_cubit.dart';
import 'package:my_school/screens/profile_screen/widgets/rounded_button.dart';
import 'package:my_school/styling/pallet.dart';
import 'package:my_school/widgets/app_nav_bar.dart';
import 'package:my_school/widgets/app_title_bar.dart';
import 'package:my_school/widgets/star_pattern_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../database/school_database.dart';
import '../../widgets/custom_image_cropper.dart';
import '../profile_screen/widgets/constrained_image.dart';

class AddEditStudentScreen extends StatefulWidget {
  const AddEditStudentScreen({
    Key? key,
    this.student,
  }) : super(key: key);

  final Student? student;

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  final TextEditingController _studentName = TextEditingController();
  final TextEditingController _grade = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  bool isBoy = true;
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  DateTime? _birthDate;
  File? originalAvatar;

  @override
  void initState() {
    super.initState();
    _fillItems();
  }

  @override
  void dispose() {
    _studentName.dispose();
    _grade.dispose();
    _dob.dispose();
    super.dispose();
  }

  _fillItems() async {
    if (widget.student != null) {
      final student = widget.student!;
      _studentName.text = student.name;
      _grade.text = student.grade;
      isBoy = student.isBoy;
      _dob.text = student.dateOfBorth != null
          ? DateFormat('yyyy, MMM, dd').format(student.dateOfBorth!)
          : '';
      if (student.imagePath != null) {
        final tempFile = File(student.imagePath!);
        final bool imageExsits = await tempFile.exists();
        if (imageExsits) {
          setState(() {
            originalAvatar = tempFile;
          });
        }
      }
    }
  }

  Future<String?> _saveImage() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    // final String path = directory.path;
    final id = '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
    final String newImagePath = path.join(directory.path, 'images', id);

    final bytes = await _croppedFile?.readAsBytes();
    if (bytes != null) {
      final File file = File(newImagePath);
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);
      setState(() {
        _pickedFile = null; // XFile(newImagePath);
        _croppedFile = null;
      });
      return newImagePath;
    } else {
      return null;
    }
  }

  _writeToDatabase(AppDatabase database) async {
    if (_studentName.text.isEmpty || _studentName.text.length < 4) {
      // bad name
    }

    if (_grade.text.isEmpty || _grade.text.length < 4) {
      // bad grade
    }

    String? avatar;
    if (_croppedFile != null) {
      final temp = await _saveImage();
      if (temp != null) {
        avatar = temp;
      }
    } else if (_pickedFile != null) {
      avatar = _pickedFile?.path;
    } else if (originalAvatar != null) {
      avatar = originalAvatar?.path;
    }
    if (widget.student == null) {
      final model = StudentsCompanion(
        name: drift.Value(_studentName.text),
        grade: drift.Value(_grade.text),
        imagePath:
            avatar != null ? drift.Value(avatar) : const drift.Value.absent(),
        isBoy: drift.Value(isBoy),
        dateOfBorth: _birthDate == null
            ? const drift.Value.absent()
            : drift.Value(_birthDate),
      );

      await database.studentsDao.insertStudent(model);
    } else {
      if (widget.student?.imagePath != null &&
          avatar != widget.student!.imagePath) {
        _deleteUserImage();
      }
      final student = widget.student!;
      final model = student.copyWith(
        name: _studentName.text,
        grade: _grade.text,
        imagePath:
            avatar != null ? drift.Value(avatar) : const drift.Value.absent(),
        isBoy: isBoy,
        dateOfBorth: _birthDate == null
            ? const drift.Value.absent()
            : drift.Value(_birthDate),
      );
      database.studentsDao.updateStudent(model);
    }
  }

  Future _deleteUserImage() async {
    if (widget.student?.imagePath != null) {
      final image = File(widget.student!.imagePath!);
      if (await image.exists()) {
        return image.delete();
      }
    }
  }

  _saveStudent(BuildContext context) async {
    final database = context.read<SchoolDatabaseCubit>().database;
    await _writeToDatabase(database);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppTitleBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: Pallet.backgroundGradient,
        ),
        child: Column(
          children: [
            const SizedBox(height: 32),
            _header(context),
            _buildContent()
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        // alignment: Alignment.topCenter,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: StarPattern(),
          ),
          _buildScrollableArea(),
        ],
      ),
    );
  }

  Container _buildScrollableArea() {
    return Container(
      margin: const EdgeInsets.only(top: 36),
      padding: const EdgeInsets.only(top: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _imageSection(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildStudentName(),
                  _buildStudentDrade(),
                  _gender(),
                  AppTextFieldWithDate(
                    controller: _dob,
                    onChange: (date) {
                      setState(() {
                        _birthDate = date;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppTextField _buildStudentName() {
    return AppTextField(
      controller: _studentName,
      hint: 'student name',
    );
  }

  AppTextField _buildStudentDrade() {
    return AppTextField(
      controller: _grade,
      hint: 'grade',
    );
  }

  Container _gender() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Pallet.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            'Is boy:',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Switch(
            value: isBoy,
            onChanged: ((value) {
              setState(() {
                isBoy = value;
              });
            }),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return AppNavBar(
      label: 'Add Student',
      actions: IconButton(
        onPressed: () => _saveStudent(context),
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
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
    const double ratio = 0.25;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedImage(
          width: size.width, height: size.height * ratio, path: path);
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedImage(
          width: size.width,
          height: size.height * ratio,
          path: path,
          isRound: false);
    } else if (originalAvatar != null) {
      return ConstrainedImage(
          width: size.width,
          height: size.height * ratio,
          path: originalAvatar!.path,
          isRound: true);
    } else {
      return ConstrainedImage(
          width: size.width,
          height: size.height * ratio,
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

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}

typedef AppTextFieldValidator = String? Function(String?);

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    this.onValidate,
    this.hint,
  }) : super(key: key);
  final TextEditingController controller;
  final String? hint;
  final AppTextFieldValidator? onValidate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Pallet.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: ((value) {
          if (onValidate != null) {
            onValidate!(value);
          }
        }),
        style: Theme.of(context).textTheme.subtitle1,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.grey.shade500),
        ),
      ),
    );
  }
}

class AppTextFieldWithDate extends StatefulWidget {
  const AppTextFieldWithDate({
    Key? key,
    required this.controller,
    required this.onChange,
    this.onValidate,
    this.hint,
  }) : super(key: key);
  final TextEditingController controller;
  final String? hint;
  final AppTextFieldValidator? onValidate;
  final Function(DateTime) onChange;

  @override
  State<AppTextFieldWithDate> createState() => _AppTextFieldWithDateState();
}

class _AppTextFieldWithDateState extends State<AppTextFieldWithDate> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Pallet.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.controller,
        onTap: () => _showDatePicker(context),
        onChanged: ((value) {
          if (widget.onValidate != null) {
            widget.onValidate!(value);
          }
        }),
        style: Theme.of(context).textTheme.subtitle1,
        readOnly: true,
        decoration: InputDecoration(
            hintText: widget.hint,
            border: InputBorder.none,
            hintStyle: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(color: Colors.grey.shade500)),
      ),
    );
  }

  _showDatePicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(DateTime.now().year - 6),
      firstDate: DateTime(DateTime.now().year - 40),
      lastDate: DateTime(DateTime.now().year - 3),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.onChange(pickedDate);
        widget.controller.text = DateFormat('yyyy, MMM, dd').format(pickedDate);
      });
    }
  }
}
