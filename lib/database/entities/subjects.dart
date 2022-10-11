//

import 'package:drift/drift.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get parentId => integer().nullable()();
  TextColumn get title => text().withLength(min: 3)();
  BoolColumn get hasDictation => boolean().withDefault(const Constant(false))();
  BoolColumn get hasExams => boolean().withDefault(const Constant(true))();
  BoolColumn get hasBranch => boolean().withDefault(const Constant(false))();
}
