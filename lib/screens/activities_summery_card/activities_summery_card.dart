// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_school/blocs/cubit/school_database_cubit.dart';
import 'package:my_school/helpers/routing/nav_link.dart';
import 'package:my_school/styling/assets.dart';
import 'package:my_school/styling/pallet.dart';

import '../../database/database_imports.dart';
import '../../database/school_database.dart';
import '../../models/activity_more_menu_item.dart';
import '../../models/all_days_list.dart';
import '../student_time_table_screen/student_time_table_screen.dart';

class ActivitiesSummeryCard extends StatefulWidget {
  const ActivitiesSummeryCard({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  @override
  State<ActivitiesSummeryCard> createState() => _ActivitiesSummeryCardState();
}

class _ActivitiesSummeryCardState extends State<ActivitiesSummeryCard> {
  _actionFor(BuildContext context, ActivityMoreMenuItem item) async {
    switch (item) {
      case ActivityMoreMenuItem.timetable:
        final database = context.read<SchoolDatabaseCubit>().database;
        final subjects = await database.studentSubjectsDao
            .getStudentActiveSubjects(widget.student.id);
        // print('_actionFor subjects count: ${subjects.length}');
        final StudentTimeTableScreenArguments rguments =
            StudentTimeTableScreenArguments(
          student: widget.student,
          subjects: subjects,
        );
        if (mounted) {
          Navigator.of(context)
              .pushNamed(NavLink.studentTimeTable, arguments: rguments);
        }

        break;
      case ActivityMoreMenuItem.notifications:
        // final database = context.read<SchoolDatabaseCubit>().database;
        // database.studentSubjectsDao.printSubjects();
        // database.studentSubjectsDao.forTestPurposes(widget.student.id);
        break;
      case ActivityMoreMenuItem.edit:
        Navigator.of(context)
            .pushNamed(NavLink.addStudent, arguments: widget.student);
        break;
      case ActivityMoreMenuItem.delete:
        _showAlertDialog(context);
        break;
      case ActivityMoreMenuItem.subjects:
        Navigator.of(context)
            .pushNamed(NavLink.studentSubjects, arguments: widget.student);
        break;
    }
  }

  Future _showAlertDialog(BuildContext context) async {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.pop(context, 'Tahseen'),
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirm",
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      content: const Text("Are you sure you want to delete this student"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      // contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 10.0),
      // elevation: 4,
      // backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [
        cancelButton,
        okButton,
      ],
    );
    // show the dialog
    final choice = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    final result = choice as String?;

    if (result != null && result == 'Tahseen') {
      // if (mounted) _deleteStudent(context);
      if (mounted) {
        _deleteStudent(context);
      }
    }
  }

  Future _deleteUserImage() async {
    if (widget.student.imagePath != null) {
      final image = File(widget.student.imagePath!);
      if (await image.exists()) {
        return image.delete();
      }
    }
  }

  Future _deleteStudent(BuildContext context) async {
    final database = context.read<SchoolDatabaseCubit>().database;

    await _deleteUserImage();

    database.studentsDao.deleteStudent(widget.student);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Card(
        color: Pallet.grey,
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(
                height: 22,
                child: Divider(color: Pallet.lightBlue),
              ),
              _activities(context),
              const SizedBox(
                height: 16,
                child: Divider(color: Pallet.lightBlue),
              ),
              _timeTable(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activities(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activities',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Pallet.darkBlue,
          ),
        ),
        const SizedBox(height: 8),
        _activitiesList(context),
      ],
    );
  }

  Widget _timeTable(BuildContext context) {
    final nextDay = DateTime.now().add(const Duration(days: 1)).weekday;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time table for ${AllDays.dayTitleFor(nextDay)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Pallet.darkBlue,
          ),
        ),
        const SizedBox(height: 8),
        _timeTbleList(context),
      ],
    );
  }

  Widget _activitiesList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'english test',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 4),
          Text(
            'arabic dectation',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget _timeTbleList(BuildContext context) {
    final cubit = context.read<SchoolDatabaseCubit>();
    return StreamBuilder(
      stream: cubit.database.studentTimeTableDao
          .dailyTimetable(widget.student.id, DateTime.now().weekday),
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.map((e) => TableTimeRowSummery(entry: e)).toList(),
          ),
        );
      },
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _avatar(context),
        // const SizedBox(width: 16),
        Expanded(
          child: Center(
            child: Text(
              widget.student.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
            color: Pallet.darkBlue,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          elevation: 4,
          color: Pallet.grey,
          onSelected: (item) => _actionFor(context, item),
          itemBuilder: (context) => ActivityMoreMenuItem.values
              .map((item) => PopupMenuItem(
                    value: item,
                    child: ActivityMenuButton(item: item),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _avatar(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(NavLink.profile, arguments: widget.student),
      child: Container(
        width: 50,
        height: 50,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: widget.student.imagePath != null
            ? Image.file(File(widget.student.imagePath!))
            : Image.asset(Assests.avatarIcon),
      ),
    );
  }
}

class ActivityMenuButton extends StatelessWidget {
  const ActivityMenuButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ActivityMoreMenuItem item;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 150,
      ),
      child: Row(
        children: [
          Icon(item.icon,
              size: 18,
              color: item == ActivityMoreMenuItem.delete
                  ? Theme.of(context).colorScheme.error
                  : null),
          const SizedBox(width: 8),
          Text(
            item.title,
            style: TextStyle(
              color: item == ActivityMoreMenuItem.delete
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class TableTimeRowSummery extends StatelessWidget {
  const TableTimeRowSummery({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final TimetableEntry entry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            '${entry.order}:',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        Expanded(
          child: Text(
            entry.toDisplay,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}
