// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_school/blocs/cubit/school_database_cubit.dart';
import 'package:my_school/helpers/routing/nav_link.dart';
import 'package:my_school/styling/pallet.dart';
import 'package:my_school/widgets/app_title_bar.dart';
import 'package:my_school/widgets/star_pattern_widget.dart';

import '../../database/database_models.dart';
import '../../database/school_database.dart';
import '../../widgets/app_nav_bar.dart';
import 'subjects_screen_widgets.dart';

enum SubjectsScreenMoreItem { add, delete }

extension SubjectsScreenMoreItemDetails on SubjectsScreenMoreItem {
  String get title {
    switch (this) {
      case SubjectsScreenMoreItem.add:
        return 'Add Subject';
      case SubjectsScreenMoreItem.delete:
        return 'Delete Subject';
    }
  }

  IconData get icon {
    switch (this) {
      case SubjectsScreenMoreItem.add:
        return Icons.add;
      case SubjectsScreenMoreItem.delete:
        return Icons.delete;
    }
  }
}

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  void _actionFor(BuildContext context,
      {required SubjectsScreenMoreItem item}) {
    switch (item) {
      case SubjectsScreenMoreItem.add:
        Navigator.of(context).pushNamed(NavLink.addPublicSubject);
        break;
      case SubjectsScreenMoreItem.delete:
        _showAddSubject(context);
        break;
    }
  }

  _saveEntry(BuildContext context, SubjectsCompanion model) {
    final database = context.read<SchoolDatabaseCubit>().database;
    database.subjectsDao.insertSubject(model);
  }

  _showAddSubject(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CraetePublicSubjectDialog(onSave: (model) {
          _saveEntry(context, model);
        });
      },
    );
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
            Expanded(
              child: Stack(
                children: [
                  const StarPattern(),
                  _buildContent(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildContent(BuildContext context) {
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
      child: _buildSubjectsList(context),
    );
  }

  Widget _header(BuildContext context) {
    return AppNavBar(
      label: 'Subjects',
      actions: PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (item) => _actionFor(context, item: item),
        itemBuilder: (context) => SubjectsScreenMoreItem.values
            .map((item) => PopupMenuItem(
                  value: item,
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(item.title),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSubjectsList(BuildContext context) {
    final stream = context
        .read<SchoolDatabaseCubit>()
        .database
        .subjectsDao
        .wathAllSubjects();
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context,
          AsyncSnapshot<List<SubjectWithBranchs>> snapshot) {
        final subjects = snapshot.data ?? [];
        return ListView.builder(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          itemCount: subjects.length,
          itemBuilder: ((context, index) {
            final subject = subjects[index];
            return SubjectMiniCard(item: subject);
          }),
        );
      },
    );
  }
}

class CraetePublicSubjectDialog extends StatefulWidget {
  const CraetePublicSubjectDialog({Key? key, required this.onSave})
      : super(key: key);
  final Function(SubjectsCompanion) onSave;
  @override
  State<CraetePublicSubjectDialog> createState() =>
      _CraetePublicSubjectDialogState();
}

class _CraetePublicSubjectDialogState extends State<CraetePublicSubjectDialog> {
  final TextEditingController subjectName = TextEditingController();
  bool hasDictation = false;
  bool hasExams = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: Text(
        "Add subject",
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: subjectName,
                autofocus: true,
                decoration: const InputDecoration(
                  isCollapsed: true,
                  hintText: 'Subject name',
                  border: InputBorder.none,
                ),
              ),
            ),
            // hasDictation,
            Row(
              children: [
                const Text('Has Dictation'),
                const SizedBox(width: 8),
                Switch(
                  value: hasDictation,
                  onChanged: ((value) => setState(() {
                        hasDictation = value;
                      })),
                ),
              ],
            ),
            // hasExams,
            Row(
              children: [
                const Text('Has Exams'),
                const SizedBox(width: 8),
                Switch(
                  value: hasExams,
                  onChanged: ((value) => setState(() {
                        hasExams = value;
                      })),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            }),
        TextButton(
            child: const Text('SAVE'),
            onPressed: () {
              final model = SubjectsCompanion.insert(
                title: subjectName.text,
                hasDictation: drift.Value(hasDictation),
                hasExams: drift.Value(hasExams),
              );
              widget.onSave(model);
              Navigator.pop(context, 'Save');
            }),
      ],
    );
  }
}
