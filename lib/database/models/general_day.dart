//

import 'general_class.dart';

class GeneralDay {
  final int dayId;
  final String day;
  final List<GeneralClass> classes;
  GeneralDay({
    required this.dayId,
    required this.day,
    required this.classes,
  });

  @override
  String toString() => 'GeneralDay(order: $classes)';
}
