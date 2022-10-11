//

import 'package:drift/drift.dart';
import 'package:my_school/database/school_database.dart';

List<SubjectsCompanion> arabicBranchs(int id) => [
      SubjectsCompanion.insert(title: 'Grammar', parentId: Value(id)),
      SubjectsCompanion.insert(title: 'Poetry', parentId: Value(id)),
      SubjectsCompanion.insert(title: 'Reading', parentId: Value(id)),
    ];

List<SubjectsCompanion> englishBranchs(int id) => [
      SubjectsCompanion.insert(title: 'Family', parentId: Value(id)),
      SubjectsCompanion.insert(title: 'Emmar', parentId: Value(id)),
    ];

SubjectsCompanion addSubject({
  int? id,
  required String title,
  bool hasBranch = false,
  bool hasDictation = false,
  bool hasExams = true,
}) {
  return SubjectsCompanion.insert(
    id: id != null ? Value(id) : const Value.absent(),
    title: title,
    hasBranch: Value(hasBranch),
    hasDictation: Value(hasDictation),
    hasExams: Value(hasExams),
  );
}
