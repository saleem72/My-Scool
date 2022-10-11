//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_school/blocs/cubit/school_database_cubit.dart';
import 'package:my_school/database/school_database.dart';
import 'package:my_school/styling/pallet.dart';
import 'package:my_school/widgets/app_title_bar.dart';

import '../../database/database_models.dart';
import '../../widgets/general_widgets.dart';
import 'models/student_subjects_menu_item.dart';
import 'student_subject_row_tile.dart';

class StudentSubjectsScreen extends StatefulWidget {
  const StudentSubjectsScreen({
    Key? key,
    required this.student,
  }) : super(key: key);
  final Student student;

  @override
  State<StudentSubjectsScreen> createState() => _StudentSubjectsScreenState();
}

class _StudentSubjectsScreenState extends State<StudentSubjectsScreen> {
  List<StudentSubjectIsSelected> testSubject = [];

  void _actionFor(BuildContext context, StudentSubjectsMenuItem item) {
    switch (item) {
      case StudentSubjectsMenuItem.addSubject:
        break;
      case StudentSubjectsMenuItem.action2:
        break;
      case StudentSubjectsMenuItem.action3:
        break;
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
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _header(context),
        Expanded(
          child: Stack(
            children: [
              const StarPattern(),
              Container(
                margin: const EdgeInsets.only(top: 36),
                padding: const EdgeInsets.only(top: 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: _buildSubjectsList(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _forTestPurposes(BuildContext context) {
    final studentSubjectsDao =
        context.read<SchoolDatabaseCubit>().database.studentSubjectsDao;

    final subjectsStream = studentSubjectsDao.watchStudentSubjects(1);
    return StreamBuilder(
      stream: subjectsStream,
      builder: (context, snapshot) {
        final subjects = snapshot.data ?? [];
        return Column(
          children: [
            Text(subjects.length.toString()),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = subjects[index];
                  return Text(
                      '${item.studentId}, ${item.subject.title}, ${item.isSelected}');
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubjectsList(BuildContext context) {
    final studentSubjectsDao =
        context.read<SchoolDatabaseCubit>().database.studentSubjectsDao;

    final subjectsStream =
        studentSubjectsDao.watchStudentSubjects(widget.student.id);

    return StreamBuilder(
      stream: subjectsStream,
      builder: (context, snapshot) {
        final subjects = snapshot.data ?? [];
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            final item = subjects[index];
            return StudentSubjectRowTile(subject: item);
          },
        );
      },
    );
  }

  AppNavBar _header(BuildContext context) {
    return AppNavBar(
      label: "${widget.student.name}'s subjects",
      // PopupMenuButton
      actions: PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          onSelected: (item) => _actionFor(context, item),
          itemBuilder: ((context) => StudentSubjectsMenuItem.values
              .map((e) => PopupMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Icon(
                          e.icon,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          e.title,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                  ))
              .toList())),
    );
  }

  _showDialog(BuildContext context) async {
    Widget addButton = TextButton(
      child: const Text("Add"),
      onPressed: () => Navigator.pop(context, 'Tahseen'),
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      title: Text('Add subject for ${widget.student.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Subject'),
        ],
      ),
      actions: [
        addButton,
        cancelButton,
      ],
    );

    final choice = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    final result = choice as String?;
    print(result ?? 'Cancel');

    // if (result != null && result == 'Tahseen') {
    //   // if (mounted) _deleteStudent(context);
    //   if (mounted) {
    //     print(result ?? '');
    //   }
    // }
  }
}
