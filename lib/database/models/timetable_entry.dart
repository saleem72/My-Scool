// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:my_school/models/all_days_list.dart';

import '../school_database.dart';

class TimetableEntry {
  final StudentClass entity;
  final Subject? subject;
  final String? parentSubject;

  TimetableEntry({
    required this.entity,
    this.subject,
    this.parentSubject,
  });

  String get toDisplay {
    if (parentSubject != null) {
      return '$parentSubject / ${subject?.title ?? ''}';
    } else {
      return subject?.title ?? '';
    }
  }

  String get order => AllDays.orderTitleFor(entity.order);

  @override
  String toString() =>
      'TimetableEntry(entity: ${entity.order}, subject: ${subject?.title ?? ''}, parentSubject: ${parentSubject ?? ''})';
}
