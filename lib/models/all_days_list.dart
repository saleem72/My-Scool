//

import 'package:my_school/styling/constants.dart';

import '../database/database_models.dart';
import 'package:collection/collection.dart';

class AllDays {
  AllDays._();

  static final allDaysList = [
    {'title': 'Sun', 'id': DateTime.sunday},
    {'title': 'Mon', 'id': DateTime.monday},
    {'title': 'Tue', 'id': DateTime.tuesday},
    {'title': 'Wen', 'id': DateTime.wednesday},
    {'title': 'Thu', 'id': DateTime.thursday},
  ];

  static List<GeneralDay> generateBlankTable() {
    List<GeneralDay> allDays = allDaysList.map((e) {
      return GeneralDay(
          dayId: e['id'] as int, day: e['title'] as String, classes: []);
    }).toList();

    for (final day in allDays) {
      for (int i = 1; i < Constants.classesCount + 1; i++) {
        final item = GeneralClass(
          dayId: day.dayId,
          day: day.day,
          order: i,
        );
        day.classes.add(item);
      }
    }

    return allDays;
  }

  static String dayTitleFor(int id) {
    int actualId = id;
    if (id == 5 || id == 6) {
      actualId = 7;
    }
    final day = allDaysList
        .firstWhereOrNull((element) => element['id'] as int == actualId);
    if (day != null) {
      return day['title'] as String;
    } else {
      return '';
    }
  }

  static String orderTitleFor(int order) {
    switch (order) {
      case 1:
        return 'First';
      case 2:
        return 'Second';
      case 3:
        return 'Third';
      case 4:
        return 'Fourth';
      case 5:
        return 'Fifth';
      case 6:
        return 'Sixth';
      case 7:
        return 'Seventh';
      default:
        return '';
    }
  }
}
