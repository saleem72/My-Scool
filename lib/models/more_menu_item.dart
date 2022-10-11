//

enum MoreMenuItem { addStudent, subjects, workingdays }

extension MoreMenuItemDetails on MoreMenuItem {
  String get title {
    switch (this) {
      case MoreMenuItem.addStudent:
        return 'Add Student';
      case MoreMenuItem.subjects:
        return 'Subjects';
      case MoreMenuItem.workingdays:
        return 'Working days';
    }
  }

  static List<MoreMenuItem> values = [
    MoreMenuItem.addStudent,
    MoreMenuItem.subjects,
    MoreMenuItem.workingdays,
  ];
}
