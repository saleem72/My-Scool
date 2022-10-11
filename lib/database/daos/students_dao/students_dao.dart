//

import 'package:drift/drift.dart';
import 'package:collection/collection.dart';

import '../../database_imports.dart';
import '../../school_database.dart';

part 'students_dao.g.dart';

@DriftAccessor(tables: [Students])
class StudentsDao extends DatabaseAccessor<AppDatabase>
    with _$StudentsDaoMixin {
  StudentsDao(AppDatabase db) : super(db);

  // Future<List<LoginEmployeeData>> getCategories() async {
  //   return await select(loginEmployee).get();
  // }
  Stream<List<Student>> wathAllStudents() => select(students).watch();
  Future<int> insertStudent(StudentsCompanion model) =>
      into(students).insert(model);

  Future updateStudent(Insertable<Student> student) =>
      update(students).replace(student);

  Future deleteStudent(Student student) async {
    delete(students).delete(student);
  }
}

@DriftAccessor(tables: [Subjects])
class SubjectsDao extends DatabaseAccessor<AppDatabase>
    with _$SubjectsDaoMixin {
  SubjectsDao(AppDatabase db) : super(db);

  Future<int> insertSubject(SubjectsCompanion model) =>
      into(subjects).insert(model);

  Future updateSubject(Insertable<Subject> subject) =>
      update(subjects).replace(subject);

  Future deleteSubject(Subject subject) async {
    delete(subjects).delete(subject);
  }

  // Future getAllSubjects() async {
  //   select(studentSub)
  // }

  Stream<List<SubjectWithBranchs>> wathAllSubjects() {
    return select(subjects).watch().map((rows) {
      List<SubjectWithBranchs> result = [];
      for (final row in rows) {
        if (row.parentId != null) {
          final parent = result.firstWhereOrNull(
              (element) => element.subject.id == row.parentId);
          if (parent != null) {
            parent.branchs.add(row);
          }
        } else {
          final item = SubjectWithBranchs(subject: row, branchs: []);
          result.add(item);
        }
      }
      return result;
    });
  }
}
