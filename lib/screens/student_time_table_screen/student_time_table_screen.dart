// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_school/blocs/cubit/school_database_cubit.dart';
import 'package:my_school/database/database_models.dart';
import 'package:my_school/screens/student_time_table_screen/student_time_table_cubit/student_time_table_cubit.dart';
import 'package:my_school/styling/constants.dart';
import 'package:my_school/widgets/star_pattern_widget.dart';

import '../../database/school_database.dart';
import '../../models/all_days_list.dart';
import '../../styling/pallet.dart';
import '../../widgets/app_nav_bar.dart';
import '../../widgets/app_title_bar.dart';
import 'student_time_table_screen_widgets.dart';

const double cellWidth = 125;
const double cellHeight = 32;

class StudentTimeTableScreenArguments {
  final Student student;
  final List<SubjectWithBranchs> subjects;
  StudentTimeTableScreenArguments({
    required this.student,
    required this.subjects,
  });
}

class StudentTimeTableScreen extends StatelessWidget {
  StudentTimeTableScreen({
    Key? key,
    required StudentTimeTableScreenArguments arguments,
  })  : student = arguments.student,
        subjects = arguments.subjects,
        super(key: key);

  final Student student;
  final List<SubjectWithBranchs> subjects;

  @override
  Widget build(BuildContext context) {
    final database = context.read<SchoolDatabaseCubit>().database;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppTitleBar(),
      body: BlocProvider(
        create: (context) => StudentTimeTableCubit(
            studentId: student.id, database: database, subjects: subjects),
        child: StudentTimeTableWidget(student: student, subjects: subjects),
      ),
    );
  }
}

class StudentTimeTableWidget extends StatelessWidget {
  const StudentTimeTableWidget({
    Key? key,
    required this.student,
    required this.subjects,
  }) : super(key: key);
  final Student student;
  final List<SubjectWithBranchs> subjects;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: Pallet.backgroundGradient,
      ),
      child: _buildContent(context),
    );
  }

  Widget _noSubjectToSelectFrom(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          'You have to fill ${student.name} subjects before fill in the time table',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                height: 1.5,
                color: Colors.white,
              ),
        ),
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
                padding: const EdgeInsets.only(top: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: subjects.isEmpty
                    ? _noSubjectToSelectFrom(context)
                    : _buildTable(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildTable(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                height: cellHeight,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Pallet.tableGuids,
                  border: const Border(
                    left: BorderSide(width: 1, color: Colors.white),
                    top: BorderSide(width: 1, color: Colors.white),
                  ),
                ),
              ),
              _daysColumn(context),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: _buildTimeTable(context),
        ),
      ],
    );
  }

  Widget _daysColumn(BuildContext context) {
    return Column(
      children: AllDays.allDaysList
          .map((e) => Container(
              height: cellHeight,
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Pallet.tableGuids,
                border: Border(
                  left: const BorderSide(width: 1, color: Colors.white),
                  top: const BorderSide(width: 1, color: Colors.white),
                  bottom: e == AllDays.allDaysList.last
                      ? const BorderSide(width: 1, color: Colors.white)
                      : BorderSide.none,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Text(e['title'] as String)))
          .toList(),
    );
  }

  Widget _buildTimeTable(BuildContext context) {
    final stream = context
        .read<StudentTimeTableCubit>()
        .database
        .studentTimeTableDao
        .getStudentTimeTable(student.id);
    return StreamBuilder(
      stream: stream,
      builder:
          (BuildContext context, AsyncSnapshot<List<GeneralDay>> snapshot) {
        final data = snapshot.data ?? [];
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              _tableHeader(),
              Column(
                children: data
                    .map((e) => SizedBox(
                          width: (cellWidth * Constants.classesCount) + 16,
                          child: TimeTableRow(
                              item: e, hasBottomBorder: e == data.last),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tableHeader() {
    return SizedBox(
      width: (cellWidth * Constants.classesCount) + 16,
      child: Row(
        children: List<int>.generate(Constants.classesCount, (i) => i + 1)
            .map((e) => Container(
                  width: cellWidth,
                  height: cellHeight,
                  decoration: BoxDecoration(
                    color: Pallet.tableGuids,
                    border: Border(
                      left: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      top: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      right: e == Constants.classesCount
                          ? const BorderSide(width: 1, color: Colors.white)
                          : BorderSide.none,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text('Class $e'),
                ))
            .toList(),
      ),
    );
  }

  AppNavBar _header(BuildContext context) {
    return AppNavBar(
      label: "${student.name}'s timetable",
    );
  }
}

class TimeTableRow extends StatelessWidget {
  const TimeTableRow({
    Key? key,
    required this.item,
    required this.hasBottomBorder,
  }) : super(key: key);

  final GeneralDay item;
  final bool hasBottomBorder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: item.classes.isEmpty
          ? []
          : item.classes
              .map((e) => TimeTableCell(
                    cell: e,
                    cellWidth: cellWidth,
                    cellHeight: cellHeight,
                    hasBottomBorder: hasBottomBorder,
                  ))
              .toList(),
    );
  }
}
