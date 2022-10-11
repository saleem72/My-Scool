//
import 'package:drift/drift.dart';
import 'package:my_school/database/database_imports.dart';

class StudentSubjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sutdentId =>
      integer().named('student_id').references(Students, #id)();
  IntColumn get subjectId =>
      integer().named('subject_id').references(Subjects, #id)();
}
