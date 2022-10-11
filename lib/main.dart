//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_school/blocs/cubit/school_database_cubit.dart';
import 'package:my_school/helpers/routing/nav_link.dart';
import 'package:my_school/styling/pallet.dart';

import 'helpers/routing/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SchoolDatabaseCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My School',
        theme: Pallet.theme,
        initialRoute: NavLink.splash,
        onGenerateRoute: RouteGenerator.generate,
      ),
    );
  }
}
