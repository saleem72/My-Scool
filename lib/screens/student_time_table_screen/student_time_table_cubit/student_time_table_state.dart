// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'student_time_table_cubit.dart';

class TimetableActiveCell extends Equatable {
  final int dayId;
  final int order;

  const TimetableActiveCell({
    required this.dayId,
    required this.order,
  });

  @override
  List<Object?> get props => [dayId, order];

  @override
  bool get stringify => true;
}
