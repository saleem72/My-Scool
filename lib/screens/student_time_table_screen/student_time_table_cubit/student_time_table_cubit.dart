import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/database_models.dart';
import '../../../database/school_database.dart';

part 'student_time_table_state.dart';

class StudentTimeTableCubit extends Cubit<TimetableActiveCell?> {
  final int studentId;
  final AppDatabase database;
  final List<SubjectWithBranchs> subjects;
  StudentTimeTableCubit({
    required this.studentId,
    required this.database,
    required this.subjects,
  }) : super(null);

  void onActiveCellChanged(TimetableActiveCell? cell) {
    if (state != cell) {
      print(cell.toString());
      emit(cell);
    }
  }

  Future onActiveCellSave({
    required GeneralClass cell,
    required StudentClassesCompanion model,
  }) async {
    if (cell.classItem != null) {
      // the row is exsits
      final updated = cell.classItem!.copyWith(
        subjectId: model.subjectId.value,
      );
      database.studentTimeTableDao.updateStudentClass(updated);
    } else {
      // it is new row
      database.studentTimeTableDao.insertStudentClass(model);
    }
  }
}
