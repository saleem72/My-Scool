//

import 'package:drift/drift.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get imagePath => text().named('image_path').nullable()();
  TextColumn get grade => text()();
  BoolColumn get isBoy => boolean().withDefault(const Constant(true))();
  DateTimeColumn get dateOfBorth =>
      dateTime().named('date_of_birth').nullable()();
}
