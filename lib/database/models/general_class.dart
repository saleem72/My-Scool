//

import '../school_database.dart';

class GeneralClass {
  final StudentClass? classItem;
  final int dayId;
  final String day;
  final int order;
  final Subject? subject;
  GeneralClass({
    this.classItem,
    required this.dayId,
    required this.day,
    required this.order,
    this.subject,
  });

  @override
  String toString() =>
      'GeneralClass(day: $day, order: ${classItem?.order ?? 0} )';
}
