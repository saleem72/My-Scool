// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String name;
  final String? imagePath;
  final String grade;
  final bool isBoy;
  final DateTime? dateOfBorth;
  const Student(
      {required this.id,
      required this.name,
      this.imagePath,
      required this.grade,
      required this.isBoy,
      this.dateOfBorth});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['grade'] = Variable<String>(grade);
    map['is_boy'] = Variable<bool>(isBoy);
    if (!nullToAbsent || dateOfBorth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBorth);
    }
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      grade: Value(grade),
      isBoy: Value(isBoy),
      dateOfBorth: dateOfBorth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBorth),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      grade: serializer.fromJson<String>(json['grade']),
      isBoy: serializer.fromJson<bool>(json['isBoy']),
      dateOfBorth: serializer.fromJson<DateTime?>(json['dateOfBorth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imagePath': serializer.toJson<String?>(imagePath),
      'grade': serializer.toJson<String>(grade),
      'isBoy': serializer.toJson<bool>(isBoy),
      'dateOfBorth': serializer.toJson<DateTime?>(dateOfBorth),
    };
  }

  Student copyWith(
          {int? id,
          String? name,
          Value<String?> imagePath = const Value.absent(),
          String? grade,
          bool? isBoy,
          Value<DateTime?> dateOfBorth = const Value.absent()}) =>
      Student(
        id: id ?? this.id,
        name: name ?? this.name,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        grade: grade ?? this.grade,
        isBoy: isBoy ?? this.isBoy,
        dateOfBorth: dateOfBorth.present ? dateOfBorth.value : this.dateOfBorth,
      );
  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('grade: $grade, ')
          ..write('isBoy: $isBoy, ')
          ..write('dateOfBorth: $dateOfBorth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, imagePath, grade, isBoy, dateOfBorth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.name == this.name &&
          other.imagePath == this.imagePath &&
          other.grade == this.grade &&
          other.isBoy == this.isBoy &&
          other.dateOfBorth == this.dateOfBorth);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> imagePath;
  final Value<String> grade;
  final Value<bool> isBoy;
  final Value<DateTime?> dateOfBorth;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.grade = const Value.absent(),
    this.isBoy = const Value.absent(),
    this.dateOfBorth = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.imagePath = const Value.absent(),
    required String grade,
    this.isBoy = const Value.absent(),
    this.dateOfBorth = const Value.absent(),
  })  : name = Value(name),
        grade = Value(grade);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imagePath,
    Expression<String>? grade,
    Expression<bool>? isBoy,
    Expression<DateTime>? dateOfBorth,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imagePath != null) 'image_path': imagePath,
      if (grade != null) 'grade': grade,
      if (isBoy != null) 'is_boy': isBoy,
      if (dateOfBorth != null) 'date_of_birth': dateOfBorth,
    });
  }

  StudentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? imagePath,
      Value<String>? grade,
      Value<bool>? isBoy,
      Value<DateTime?>? dateOfBorth}) {
    return StudentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      grade: grade ?? this.grade,
      isBoy: isBoy ?? this.isBoy,
      dateOfBorth: dateOfBorth ?? this.dateOfBorth,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (isBoy.present) {
      map['is_boy'] = Variable<bool>(isBoy.value);
    }
    if (dateOfBorth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBorth.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imagePath: $imagePath, ')
          ..write('grade: $grade, ')
          ..write('isBoy: $isBoy, ')
          ..write('dateOfBorth: $dateOfBorth')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _isBoyMeta = const VerificationMeta('isBoy');
  @override
  late final GeneratedColumn<bool> isBoy = GeneratedColumn<bool>(
      'is_boy', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_boy IN (0, 1))',
      defaultValue: const Constant(true));
  final VerificationMeta _dateOfBorthMeta =
      const VerificationMeta('dateOfBorth');
  @override
  late final GeneratedColumn<DateTime> dateOfBorth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, imagePath, grade, isBoy, dateOfBorth];
  @override
  String get aliasedName => _alias ?? 'students';
  @override
  String get actualTableName => 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('is_boy')) {
      context.handle(
          _isBoyMeta, isBoy.isAcceptableOrUnknown(data['is_boy']!, _isBoyMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBorthMeta,
          dateOfBorth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBorthMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      imagePath: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      grade: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}grade'])!,
      isBoy: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_boy'])!,
      dateOfBorth: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final int? parentId;
  final String title;
  final bool hasDictation;
  final bool hasExams;
  final bool hasBranch;
  const Subject(
      {required this.id,
      this.parentId,
      required this.title,
      required this.hasDictation,
      required this.hasExams,
      required this.hasBranch});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['title'] = Variable<String>(title);
    map['has_dictation'] = Variable<bool>(hasDictation);
    map['has_exams'] = Variable<bool>(hasExams);
    map['has_branch'] = Variable<bool>(hasBranch);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      title: Value(title),
      hasDictation: Value(hasDictation),
      hasExams: Value(hasExams),
      hasBranch: Value(hasBranch),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      title: serializer.fromJson<String>(json['title']),
      hasDictation: serializer.fromJson<bool>(json['hasDictation']),
      hasExams: serializer.fromJson<bool>(json['hasExams']),
      hasBranch: serializer.fromJson<bool>(json['hasBranch']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'title': serializer.toJson<String>(title),
      'hasDictation': serializer.toJson<bool>(hasDictation),
      'hasExams': serializer.toJson<bool>(hasExams),
      'hasBranch': serializer.toJson<bool>(hasBranch),
    };
  }

  Subject copyWith(
          {int? id,
          Value<int?> parentId = const Value.absent(),
          String? title,
          bool? hasDictation,
          bool? hasExams,
          bool? hasBranch}) =>
      Subject(
        id: id ?? this.id,
        parentId: parentId.present ? parentId.value : this.parentId,
        title: title ?? this.title,
        hasDictation: hasDictation ?? this.hasDictation,
        hasExams: hasExams ?? this.hasExams,
        hasBranch: hasBranch ?? this.hasBranch,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('title: $title, ')
          ..write('hasDictation: $hasDictation, ')
          ..write('hasExams: $hasExams, ')
          ..write('hasBranch: $hasBranch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, parentId, title, hasDictation, hasExams, hasBranch);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.title == this.title &&
          other.hasDictation == this.hasDictation &&
          other.hasExams == this.hasExams &&
          other.hasBranch == this.hasBranch);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> title;
  final Value<bool> hasDictation;
  final Value<bool> hasExams;
  final Value<bool> hasBranch;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.title = const Value.absent(),
    this.hasDictation = const Value.absent(),
    this.hasExams = const Value.absent(),
    this.hasBranch = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String title,
    this.hasDictation = const Value.absent(),
    this.hasExams = const Value.absent(),
    this.hasBranch = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? title,
    Expression<bool>? hasDictation,
    Expression<bool>? hasExams,
    Expression<bool>? hasBranch,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (title != null) 'title': title,
      if (hasDictation != null) 'has_dictation': hasDictation,
      if (hasExams != null) 'has_exams': hasExams,
      if (hasBranch != null) 'has_branch': hasBranch,
    });
  }

  SubjectsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? parentId,
      Value<String>? title,
      Value<bool>? hasDictation,
      Value<bool>? hasExams,
      Value<bool>? hasBranch}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
      hasDictation: hasDictation ?? this.hasDictation,
      hasExams: hasExams ?? this.hasExams,
      hasBranch: hasBranch ?? this.hasBranch,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (hasDictation.present) {
      map['has_dictation'] = Variable<bool>(hasDictation.value);
    }
    if (hasExams.present) {
      map['has_exams'] = Variable<bool>(hasExams.value);
    }
    if (hasBranch.present) {
      map['has_branch'] = Variable<bool>(hasBranch.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('title: $title, ')
          ..write('hasDictation: $hasDictation, ')
          ..write('hasExams: $hasExams, ')
          ..write('hasBranch: $hasBranch')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title =
      GeneratedColumn<String>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 3,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  final VerificationMeta _hasDictationMeta =
      const VerificationMeta('hasDictation');
  @override
  late final GeneratedColumn<bool> hasDictation = GeneratedColumn<bool>(
      'has_dictation', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_dictation IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _hasExamsMeta = const VerificationMeta('hasExams');
  @override
  late final GeneratedColumn<bool> hasExams = GeneratedColumn<bool>(
      'has_exams', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_exams IN (0, 1))',
      defaultValue: const Constant(true));
  final VerificationMeta _hasBranchMeta = const VerificationMeta('hasBranch');
  @override
  late final GeneratedColumn<bool> hasBranch = GeneratedColumn<bool>(
      'has_branch', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (has_branch IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, parentId, title, hasDictation, hasExams, hasBranch];
  @override
  String get aliasedName => _alias ?? 'subjects';
  @override
  String get actualTableName => 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('has_dictation')) {
      context.handle(
          _hasDictationMeta,
          hasDictation.isAcceptableOrUnknown(
              data['has_dictation']!, _hasDictationMeta));
    }
    if (data.containsKey('has_exams')) {
      context.handle(_hasExamsMeta,
          hasExams.isAcceptableOrUnknown(data['has_exams']!, _hasExamsMeta));
    }
    if (data.containsKey('has_branch')) {
      context.handle(_hasBranchMeta,
          hasBranch.isAcceptableOrUnknown(data['has_branch']!, _hasBranchMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      parentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      hasDictation: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}has_dictation'])!,
      hasExams: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}has_exams'])!,
      hasBranch: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}has_branch'])!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class StudentSubject extends DataClass implements Insertable<StudentSubject> {
  final int id;
  final int sutdentId;
  final int subjectId;
  const StudentSubject(
      {required this.id, required this.sutdentId, required this.subjectId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(sutdentId);
    map['subject_id'] = Variable<int>(subjectId);
    return map;
  }

  StudentSubjectsCompanion toCompanion(bool nullToAbsent) {
    return StudentSubjectsCompanion(
      id: Value(id),
      sutdentId: Value(sutdentId),
      subjectId: Value(subjectId),
    );
  }

  factory StudentSubject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentSubject(
      id: serializer.fromJson<int>(json['id']),
      sutdentId: serializer.fromJson<int>(json['sutdentId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sutdentId': serializer.toJson<int>(sutdentId),
      'subjectId': serializer.toJson<int>(subjectId),
    };
  }

  StudentSubject copyWith({int? id, int? sutdentId, int? subjectId}) =>
      StudentSubject(
        id: id ?? this.id,
        sutdentId: sutdentId ?? this.sutdentId,
        subjectId: subjectId ?? this.subjectId,
      );
  @override
  String toString() {
    return (StringBuffer('StudentSubject(')
          ..write('id: $id, ')
          ..write('sutdentId: $sutdentId, ')
          ..write('subjectId: $subjectId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sutdentId, subjectId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentSubject &&
          other.id == this.id &&
          other.sutdentId == this.sutdentId &&
          other.subjectId == this.subjectId);
}

class StudentSubjectsCompanion extends UpdateCompanion<StudentSubject> {
  final Value<int> id;
  final Value<int> sutdentId;
  final Value<int> subjectId;
  const StudentSubjectsCompanion({
    this.id = const Value.absent(),
    this.sutdentId = const Value.absent(),
    this.subjectId = const Value.absent(),
  });
  StudentSubjectsCompanion.insert({
    this.id = const Value.absent(),
    required int sutdentId,
    required int subjectId,
  })  : sutdentId = Value(sutdentId),
        subjectId = Value(subjectId);
  static Insertable<StudentSubject> custom({
    Expression<int>? id,
    Expression<int>? sutdentId,
    Expression<int>? subjectId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sutdentId != null) 'student_id': sutdentId,
      if (subjectId != null) 'subject_id': subjectId,
    });
  }

  StudentSubjectsCompanion copyWith(
      {Value<int>? id, Value<int>? sutdentId, Value<int>? subjectId}) {
    return StudentSubjectsCompanion(
      id: id ?? this.id,
      sutdentId: sutdentId ?? this.sutdentId,
      subjectId: subjectId ?? this.subjectId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sutdentId.present) {
      map['student_id'] = Variable<int>(sutdentId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentSubjectsCompanion(')
          ..write('id: $id, ')
          ..write('sutdentId: $sutdentId, ')
          ..write('subjectId: $subjectId')
          ..write(')'))
        .toString();
  }
}

class $StudentSubjectsTable extends StudentSubjects
    with TableInfo<$StudentSubjectsTable, StudentSubject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentSubjectsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _sutdentIdMeta = const VerificationMeta('sutdentId');
  @override
  late final GeneratedColumn<int> sutdentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES students (id)');
  final VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES subjects (id)');
  @override
  List<GeneratedColumn> get $columns => [id, sutdentId, subjectId];
  @override
  String get aliasedName => _alias ?? 'student_subjects';
  @override
  String get actualTableName => 'student_subjects';
  @override
  VerificationContext validateIntegrity(Insertable<StudentSubject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_sutdentIdMeta,
          sutdentId.isAcceptableOrUnknown(data['student_id']!, _sutdentIdMeta));
    } else if (isInserting) {
      context.missing(_sutdentIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentSubject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentSubject(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sutdentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      subjectId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}subject_id'])!,
    );
  }

  @override
  $StudentSubjectsTable createAlias(String alias) {
    return $StudentSubjectsTable(attachedDatabase, alias);
  }
}

class StudentClass extends DataClass implements Insertable<StudentClass> {
  final int id;
  final int studentId;
  final int subjectId;
  final int dayId;
  final int order;
  const StudentClass(
      {required this.id,
      required this.studentId,
      required this.subjectId,
      required this.dayId,
      required this.order});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['student_id'] = Variable<int>(studentId);
    map['subject_id'] = Variable<int>(subjectId);
    map['day_id'] = Variable<int>(dayId);
    map['order'] = Variable<int>(order);
    return map;
  }

  StudentClassesCompanion toCompanion(bool nullToAbsent) {
    return StudentClassesCompanion(
      id: Value(id),
      studentId: Value(studentId),
      subjectId: Value(subjectId),
      dayId: Value(dayId),
      order: Value(order),
    );
  }

  factory StudentClass.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentClass(
      id: serializer.fromJson<int>(json['id']),
      studentId: serializer.fromJson<int>(json['studentId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      dayId: serializer.fromJson<int>(json['dayId']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'studentId': serializer.toJson<int>(studentId),
      'subjectId': serializer.toJson<int>(subjectId),
      'dayId': serializer.toJson<int>(dayId),
      'order': serializer.toJson<int>(order),
    };
  }

  StudentClass copyWith(
          {int? id, int? studentId, int? subjectId, int? dayId, int? order}) =>
      StudentClass(
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        subjectId: subjectId ?? this.subjectId,
        dayId: dayId ?? this.dayId,
        order: order ?? this.order,
      );
  @override
  String toString() {
    return (StringBuffer('StudentClass(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('dayId: $dayId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, studentId, subjectId, dayId, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentClass &&
          other.id == this.id &&
          other.studentId == this.studentId &&
          other.subjectId == this.subjectId &&
          other.dayId == this.dayId &&
          other.order == this.order);
}

class StudentClassesCompanion extends UpdateCompanion<StudentClass> {
  final Value<int> id;
  final Value<int> studentId;
  final Value<int> subjectId;
  final Value<int> dayId;
  final Value<int> order;
  const StudentClassesCompanion({
    this.id = const Value.absent(),
    this.studentId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.dayId = const Value.absent(),
    this.order = const Value.absent(),
  });
  StudentClassesCompanion.insert({
    this.id = const Value.absent(),
    required int studentId,
    required int subjectId,
    required int dayId,
    required int order,
  })  : studentId = Value(studentId),
        subjectId = Value(subjectId),
        dayId = Value(dayId),
        order = Value(order);
  static Insertable<StudentClass> custom({
    Expression<int>? id,
    Expression<int>? studentId,
    Expression<int>? subjectId,
    Expression<int>? dayId,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (studentId != null) 'student_id': studentId,
      if (subjectId != null) 'subject_id': subjectId,
      if (dayId != null) 'day_id': dayId,
      if (order != null) 'order': order,
    });
  }

  StudentClassesCompanion copyWith(
      {Value<int>? id,
      Value<int>? studentId,
      Value<int>? subjectId,
      Value<int>? dayId,
      Value<int>? order}) {
    return StudentClassesCompanion(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      subjectId: subjectId ?? this.subjectId,
      dayId: dayId ?? this.dayId,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<int>(studentId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (dayId.present) {
      map['day_id'] = Variable<int>(dayId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentClassesCompanion(')
          ..write('id: $id, ')
          ..write('studentId: $studentId, ')
          ..write('subjectId: $subjectId, ')
          ..write('dayId: $dayId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $StudentClassesTable extends StudentClasses
    with TableInfo<$StudentClassesTable, StudentClass> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentClassesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _studentIdMeta = const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<int> studentId = GeneratedColumn<int>(
      'student_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES students (id)');
  final VerificationMeta _subjectIdMeta = const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES subjects (id)');
  final VerificationMeta _dayIdMeta = const VerificationMeta('dayId');
  @override
  late final GeneratedColumn<int> dayId = GeneratedColumn<int>(
      'day_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, studentId, subjectId, dayId, order];
  @override
  String get aliasedName => _alias ?? 'student_classes';
  @override
  String get actualTableName => 'student_classes';
  @override
  VerificationContext validateIntegrity(Insertable<StudentClass> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('day_id')) {
      context.handle(
          _dayIdMeta, dayId.isAcceptableOrUnknown(data['day_id']!, _dayIdMeta));
    } else if (isInserting) {
      context.missing(_dayIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentClass map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentClass(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      studentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}student_id'])!,
      subjectId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}subject_id'])!,
      dayId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}day_id'])!,
      order: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
    );
  }

  @override
  $StudentClassesTable createAlias(String alias) {
    return $StudentClassesTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $StudentsTable students = $StudentsTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $StudentSubjectsTable studentSubjects =
      $StudentSubjectsTable(this);
  late final $StudentClassesTable studentClasses = $StudentClassesTable(this);
  late final StudentsDao studentsDao = StudentsDao(this as AppDatabase);
  late final SubjectsDao subjectsDao = SubjectsDao(this as AppDatabase);
  late final StudentSubjectsDao studentSubjectsDao =
      StudentSubjectsDao(this as AppDatabase);
  late final StudentTimeTableDao studentTimeTableDao =
      StudentTimeTableDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [students, subjects, studentSubjects, studentClasses];
}
