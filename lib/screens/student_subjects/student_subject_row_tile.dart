//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_school/styling/pallet.dart';

import '../../blocs/cubit/school_database_cubit.dart';
import '../../database/database_models.dart';
import '../../database/school_database.dart';

class StudentSubjectRowTile extends StatefulWidget {
  const StudentSubjectRowTile({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final StudentSubjectIsSelected subject;

  @override
  State<StudentSubjectRowTile> createState() => _StudentSubjectRowTileState();
}

class _StudentSubjectRowTileState extends State<StudentSubjectRowTile> {
  late bool isCollapsed;
  late bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = widget.subject.isSelected;
    isCollapsed = _getIsCollapsed();
  }

  bool _getIsCollapsed() {
    for (final branch in widget.subject.branchs) {
      if (branch.isSelected) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final studentSubjectsDao =
        context.read<SchoolDatabaseCubit>().database.studentSubjectsDao;
    final subject = widget.subject;
    return Container(
      padding: EdgeInsets.only(top: isCollapsed ? 0 : 16, left: 16, right: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: subject.branchs.isEmpty
          ? _singleSubject(context, widget.subject)
          : _subjectWithBramchs(subject, studentSubjectsDao),
    );
  }

  Widget _subjectWithBramchs(
      StudentSubjectIsSelected subject, StudentSubjectsDao studentSubjectsDao) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Column(
        mainAxisAlignment:
            isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          _subjectWithBranchsTitleBar(subject, studentSubjectsDao),
          isCollapsed ? const SizedBox.shrink() : const Divider(),
          _subjectBranchs()
        ],
      ),
    );
  }

  Container _subjectWithBranchsTitleBar(
      StudentSubjectIsSelected subject, StudentSubjectsDao studentSubjectsDao) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      constraints: const BoxConstraints(minHeight: 48),
      child: _subjectWithBranchsTitleBarContent(subject, studentSubjectsDao),
    );
  }

  Widget _subjectBranchs() {
    return isCollapsed
        ? const SizedBox.shrink()
        : Column(
            children: widget.subject.branchs
                .map((e) => _singleSubject(context, e))
                .toList(),
          );
  }

  Widget _subjectWithBranchsTitleBarContent(
      StudentSubjectIsSelected subject, StudentSubjectsDao studentSubjectsDao) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject.subject.title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Pallet.darkBlue,
                  ),
            ),
            Row(
              children: [
                Text(
                  'Has Branchs',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(width: 16),
                _toggleCollapseSwitch(),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(child: Container()),
        _toggleSubjectSwitch(subject, studentSubjectsDao),
      ],
    );
  }

  Switch _toggleSubjectSwitch(
      StudentSubjectIsSelected subject, StudentSubjectsDao studentSubjectsDao) {
    return Switch(
      value: subject.isSelected,
      onChanged: (value) {
        if (subject.connection == null) {
          studentSubjectsDao
              .insertStudentSubject(StudentSubjectsCompanion.insert(
            sutdentId: subject.studentId,
            subjectId: subject.subject.id,
          ));
        } else {
          studentSubjectsDao.deleteStudentSubject(subject.connection!);
        }
      },
    );
  }

  Switch _toggleCollapseSwitch() {
    return Switch(
      value: !isCollapsed,
      onChanged: (value) {
        setState(() {
          isCollapsed = !isCollapsed;
        });
      },
    );
  }

  Widget _singleSubject(BuildContext context, StudentSubjectIsSelected item) {
    final StudentSubjectsDao studentSubjectsDao =
        context.read<SchoolDatabaseCubit>().database.studentSubjectsDao;
    return Row(
      children: [
        Text(
          item.subject.title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Pallet.darkBlue,
              ),
        ),
        Expanded(child: Container()),
        Switch(
          value: item.isSelected,
          onChanged: (value) {
            if (item.connection == null) {
              final parentId = item.subject.parentId;
              if (parentId != null) {
                /// here is the problem!!!!!!!
                studentSubjectsDao
                    .addStudentSubjectIfNeeded(StudentSubjectsCompanion.insert(
                  sutdentId: item.studentId,
                  subjectId: parentId,
                ));
              }
              studentSubjectsDao
                  .insertStudentSubject(StudentSubjectsCompanion.insert(
                sutdentId: item.studentId,
                subjectId: item.subject.id,
              ));
            } else {
              studentSubjectsDao.deleteStudentSubject(item.connection!);
            }
          },
        ),
      ],
    );
  }
}
