//

import 'package:drift/drift.dart';
import 'package:collection/collection.dart';

import '../../database_imports.dart';
import '../../school_database.dart';

part 'student_subjects_dao.g.dart';

@DriftAccessor(tables: [Students, Subjects, StudentSubjects, StudentClasses])
class StudentSubjectsDao extends DatabaseAccessor<AppDatabase>
    with _$StudentSubjectsDaoMixin {
  StudentSubjectsDao(AppDatabase db) : super(db);

  // SELECT subjects.*, subjectsbranchs.*
  // FROM subjects LEFT JOIN subjectsbranchs ON subjects.id = subjectsbranchs.subject_id;

  Stream<List<StudentSubjectIsSelected>> forTestPurposes(int studentId) {
    final otherStudentSubjects = alias(studentSubjects, 'inStudentsSubjects');
    return select(subjects)
        //
        .join([
          //

          // leftOuterJoin(
          //   otherStudentSubjects,
          //   otherStudentSubjects.sutdentId.equals(1),
          //   useColumns: false,
          // ),
          leftOuterJoin(
            studentSubjects,
            studentSubjects.subjectId.equalsExp(subjects.id) &
                studentSubjects.sutdentId.equals(1),
          ),
        ])
        .watch()
        .map((rows) {
          final List<StudentSubjectIsSelected> result = [];
          for (final row in rows) {
            final subject = row.readTable(subjects);
            final connection = row.readTableOrNull(studentSubjects);
            final item = StudentSubjectIsSelected(
              studentId: 1,
              subject: subject,
              branchs: [],
              isSelected: connection != null,
              connection: connection,
            );
            if (subject.parentId != null) {
              // subject is sub has to be added to the parent
              StudentSubjectIsSelected? parent = result.firstWhereOrNull(
                  (element) => element.subject.id == subject.parentId);
              if (parent != null) {
                parent.branchs.add(item);
              }
            } else {
              // sibject is main has to add to result
              result.add(item);
            }
          }
          return result;
        });
  }

  Future<List<SubjectWithBranchs>> getStudentActiveSubjects(
      int studentId) async {
    final data = await select(studentSubjects).join([
      leftOuterJoin(
          subjects,
          studentSubjects.subjectId.equalsExp(subjects.id) &
              studentSubjects.sutdentId.equals(studentId)),
    ]).map((row) {
      return row.readTableOrNull(subjects);
    }).get();

    final allSubjects = data.whereType<Subject>().toList();

    allSubjects.sort(((a, b) => a.id.compareTo(b.id)));

    List<SubjectWithBranchs> result = [];
    for (final subject in allSubjects) {
      if (subject.parentId == null) {
        final item = SubjectWithBranchs(subject: subject, branchs: []);
        result.add(item);
      } else {
        final parent = result.firstWhereOrNull(
            (element) => element.subject.id == subject.parentId);
        if (parent != null) {
          parent.branchs.add(subject);
        }
      }
    }

    return result;
  }

  Stream<List<StudentSubjectIsSelected>> watchStudentSubjects(int studentId) {
    var query = select(subjects)
        //
        .join([
      leftOuterJoin(
        studentSubjects,
        studentSubjects.subjectId.equalsExp(subjects.id) &
            studentSubjects.sutdentId.equals(studentId),
      ),
    ]);

    return query
        .map((row) {
          final returnedSubjects = row.readTable(subjects);
          final returnedDetails = row.readTableOrNull(studentSubjects);
          return StudentSubjectIsSelected(
            studentId: studentId,
            subject: returnedSubjects,
            connection: returnedDetails,
            branchs: [],
            isSelected: returnedDetails != null,
          );
        })
        .watch()
        .map((rows) {
          final List<StudentSubjectIsSelected> result = [];
          for (final row in rows) {
            if (row.subject.parentId != null) {
              // subject is sub has to be added to the parent
              StudentSubjectIsSelected? parent = result.firstWhereOrNull(
                  (element) => element.subject.id == row.subject.parentId);
              if (parent != null) {
                parent.branchs.add(row);
              }
            } else {
              // sibject is main has to add to result
              result.add(row);
            }
          }
          return result;
        });
  }

  Future updateStudentSubject(StudentSubject model) =>
      update(studentSubjects).replace(model);
  Future insertStudentSubject(Insertable<StudentSubject> model) =>
      into(studentSubjects).insert(model);

  Future addStudentSubjectIfNeeded(StudentSubjectsCompanion model) async {
    final temp = await (select(studentSubjects)
          ..where((tbl) =>
              tbl.sutdentId.equals(model.sutdentId.value) &
              tbl.subjectId.equals(model.subjectId.value)))
        .get();
    final first = temp.firstOrNull;
    if (first == null) {
      into(studentSubjects).insert(model);
    }
  }

  Future deleteStudentSubject(StudentSubject model) =>
      delete(studentSubjects).delete(model);
}
