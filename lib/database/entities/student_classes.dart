//

import 'package:drift/drift.dart';
import 'package:my_school/database/database_imports.dart';

// class WeekDays extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get title => text().withLength(min: 3)();
// }

@DataClassName('StudentClass')
class StudentClasses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get subjectId => integer().references(Subjects, #id)();
  IntColumn get dayId => integer()();
  IntColumn get order => integer()();
}
