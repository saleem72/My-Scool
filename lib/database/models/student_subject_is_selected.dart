//

import '../school_database.dart';

class StudentSubjectIsSelected {
  final int studentId;
  final Subject subject;
  final StudentSubject? connection;
  final bool isSelected;
  final List<StudentSubjectIsSelected> branchs;

  StudentSubjectIsSelected({
    required this.studentId,
    required this.subject,
    this.connection,
    required this.isSelected,
    required this.branchs,
  });

  StudentSubjectIsSelected copyWith({
    int? studentId,
    Subject? subject,
    StudentSubject? connection,
    bool? isSelected,
    List<StudentSubjectIsSelected>? branchs,
  }) {
    return StudentSubjectIsSelected(
      studentId: studentId ?? this.studentId,
      subject: subject ?? this.subject,
      connection: connection ?? this.connection,
      isSelected: isSelected ?? this.isSelected,
      branchs: branchs ?? this.branchs,
    );
  }

  @override
  String toString() {
    return 'StudentSubjectIsSelected(studentId: $studentId, subject: ${subject.title}, connection: ${connection?.id ?? 'null'}, isSelected: $isSelected)';
  }
}
