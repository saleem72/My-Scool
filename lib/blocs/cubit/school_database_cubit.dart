import 'package:bloc/bloc.dart';

import '../../database/school_database.dart';

part 'school_database_state.dart';

class SchoolDatabaseCubit extends Cubit<SchoolDatabaseState> {
  final _database = AppDatabase();
  SchoolDatabaseCubit() : super(SchoolDatabaseState());

  AppDatabase get database => _database;
}
