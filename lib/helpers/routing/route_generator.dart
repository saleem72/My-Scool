//

import 'package:flutter/material.dart';
import 'package:my_school/helpers/routing/routing_error.dart';

import '../../database/school_database.dart';
import '../../screens/all_screens.dart';
import 'nav_link.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generate(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case NavLink.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case NavLink.initial:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case NavLink.profile:
        if (arguments is Student) {
          return MaterialPageRoute(
            builder: (context) => ProfileScreen(student: arguments),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const RoutingError(
                errorMessage:
                    "You haven't pass right arguments to profile screen"),
          );
        }
      case NavLink.addStudent:
        return MaterialPageRoute(
            builder: ((_) => AddEditStudentScreen(
                  student: arguments != null ? arguments as Student : null,
                )));
      case NavLink.subjects:
        return MaterialPageRoute(builder: (_) => const SubjectsScreen());

      case NavLink.studentSubjects:
        if (arguments is Student) {
          return MaterialPageRoute(
            builder: (context) => StudentSubjectsScreen(student: arguments),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const RoutingError(
                errorMessage:
                    "You haven't pass right arguments to profile screen"),
          );
        }

      case NavLink.studentTimeTable:
        if (arguments is StudentTimeTableScreenArguments) {
          return MaterialPageRoute(
            builder: (context) => StudentTimeTableScreen(arguments: arguments),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const RoutingError(
                errorMessage:
                    "You haven't pass right arguments to profile screen"),
          );
        }
      case NavLink.addPublicSubject:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              RoutingError(errorMessage: "Unknow route ${settings.name}"),
        );
    }
  }
}
