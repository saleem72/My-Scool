//

import 'package:drift/drift.dart';

import '../../../models/all_days_list.dart';
import '../../database_imports.dart';
import '../../school_database.dart';

// part '../school_database.g.dart';
part 'student_time_table_dao.g.dart';

@DriftAccessor(tables: [Students, Subjects, StudentSubjects, StudentClasses])
class StudentTimeTableDao extends DatabaseAccessor<AppDatabase>
    with _$StudentTimeTableDaoMixin {
  StudentTimeTableDao(AppDatabase db) : super(db);

  Stream<List<GeneralDay>> getStudentTimeTable(int studentId) {
    List<GeneralDay> allDays = AllDays.generateBlankTable();

    final allEntries = select(studentClasses).join([
      leftOuterJoin(subjects, studentClasses.subjectId.equalsExp(subjects.id)),
    ])
      ..where(studentClasses.studentId.equals(studentId));

    return allEntries.watch().map((rows) {
      for (final row in rows) {
        final classItem = row.readTableOrNull(studentClasses);
        final subject = row.readTableOrNull(subjects);
        final item = GeneralClass(
          classItem: classItem,
          day: AllDays.dayTitleFor(classItem?.dayId ?? 0),
          dayId: classItem?.dayId ?? 0,
          order: classItem?.order ?? 1,
          subject: subject,
        );

        final day =
            allDays.firstWhere((element) => element.dayId == item.dayId);

        day.classes[item.order - 1] = item;
      }

      return allDays;
    });
  }

  Stream<List<TimetableEntry>> dailyTimetable(int studentId, int dayId) {
    int actualDayId = dayId;

    if (dayId == 5 || dayId == 6) {
      actualDayId = 7;
    }

    final otherSubjects = alias(subjects, 'inStudentsSubjects');

    final allEntries = select(studentClasses).join([
      leftOuterJoin(subjects, studentClasses.subjectId.equalsExp(subjects.id)),
      leftOuterJoin(
          otherSubjects, subjects.parentId.equalsExp(otherSubjects.id)),
    ])
      ..where(studentClasses.studentId.equals(studentId) &
          studentClasses.dayId.equals(actualDayId));
    return allEntries.watch().map((rows) {
      final List<TimetableEntry> result = [];
      for (final row in rows) {
        final entity = row.readTable(studentClasses);
        final subject = row.readTableOrNull(subjects);
        final parentSubject = row.readTableOrNull(otherSubjects);
        final item = TimetableEntry(
          entity: entity,
          subject: subject,
          parentSubject: parentSubject?.title,
        );
        result.add(item);
      }

      result.sort((a, b) => a.entity.order.compareTo(b.entity.order));

      return result;
    });
  }

  Future insertStudentClass(StudentClassesCompanion model) async {
    into(studentClasses).insert(model);
  }

  Future updateStudentClass(StudentClass model) async {
    update(studentClasses).replace(model);
  }
}
