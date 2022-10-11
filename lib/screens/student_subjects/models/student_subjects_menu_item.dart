//

import 'package:flutter/material.dart';

enum StudentSubjectsMenuItem { addSubject, action2, action3 }

extension StudentSubjectsMenuItemDetails on StudentSubjectsMenuItem {
  String get title {
    switch (this) {
      case StudentSubjectsMenuItem.addSubject:
        return 'Add Subject';
      case StudentSubjectsMenuItem.action2:
        return 'Action 2';
      case StudentSubjectsMenuItem.action3:
        return 'Action 3';
    }
  }

  IconData get icon {
    switch (this) {
      case StudentSubjectsMenuItem.addSubject:
        return Icons.add;
      case StudentSubjectsMenuItem.action2:
        return Icons.question_mark;
      case StudentSubjectsMenuItem.action3:
        return Icons.question_mark;
    }
  }
}
