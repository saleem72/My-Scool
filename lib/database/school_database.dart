// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'creation_procedures.dart';
import 'database_imports.dart';
export 'database_daos.dart';

part 'school_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [Students, Subjects, StudentSubjects, StudentClasses],
  daos: [StudentsDao, SubjectsDao, StudentSubjectsDao, StudentTimeTableDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (m) async {
        await m.createAll();
        await batch((batch) {
          batch.insertAll(subjects, [
            addSubject(id: 1, title: 'Mathematics', hasBranch: true),
            addSubject(
                id: 2, title: 'Arabic', hasBranch: true, hasDictation: true),
            addSubject(id: 3, title: 'English', hasDictation: true),
            addSubject(title: 'Science'),
            addSubject(title: 'Religin', hasBranch: true),
            addSubject(title: 'Frensh', hasBranch: true),
            addSubject(title: 'Sport', hasBranch: true),
            addSubject(title: 'Art', hasBranch: true),
            addSubject(title: 'Sentimental', hasBranch: true),
            addSubject(title: 'Social', hasBranch: true),
          ]);
          batch.insertAll(subjects, englishBranchs(3));
          batch.insertAll(subjects, arabicBranchs(2));
        });
      },
    );
  }
}
