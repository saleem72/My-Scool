//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_school/blocs/cubit/school_database_cubit.dart';

import '../../../database/school_database.dart';
import '../../activities_summery_card/activities_summery_card.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentsStream = context
        .read<SchoolDatabaseCubit>()
        .database
        .studentsDao
        .wathAllStudents();
    return StreamBuilder(
        stream: studentsStream,
        builder: ((context, AsyncSnapshot<List<Student>> snapshot) {
          final students = snapshot.data ?? [];
          return ListView.builder(
              itemCount: students.length,
              itemBuilder: ((context, index) {
                return ActivitiesSummeryCard(student: students[index]);
              }));
        }));
  }
}
