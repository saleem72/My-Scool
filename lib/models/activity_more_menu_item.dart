//

import 'package:flutter/material.dart';

enum ActivityMoreMenuItem { timetable, notifications, subjects, edit, delete }

extension ActivityMoreMenuItemDetails on ActivityMoreMenuItem {
  String get title {
    switch (this) {
      case ActivityMoreMenuItem.timetable:
        return 'Time table';
      case ActivityMoreMenuItem.notifications:
        return 'Events';
      case ActivityMoreMenuItem.delete:
        return 'Delete';
      case ActivityMoreMenuItem.edit:
        return 'Edit';
      case ActivityMoreMenuItem.subjects:
        return 'Subjects';
    }
  }

  IconData get icon {
    switch (this) {
      case ActivityMoreMenuItem.timetable:
        return Icons.schedule;
      case ActivityMoreMenuItem.notifications:
        return Icons.notifications;
      case ActivityMoreMenuItem.delete:
        return Icons.delete;
      case ActivityMoreMenuItem.edit:
        return Icons.edit;
      case ActivityMoreMenuItem.subjects:
        return Icons.document_scanner;
    }
  }

  static List<ActivityMoreMenuItem> values = [
    ActivityMoreMenuItem.timetable,
    ActivityMoreMenuItem.notifications,
    ActivityMoreMenuItem.edit,
    ActivityMoreMenuItem.delete,
  ];
}

/*
enum ActivityMoreMenuItemTyep { timetable, notifications, delete }

class ActivityMoreMenuItem extends ContextMenuItem {
  @override
  final String title;
  @override
  final IconData icon;
  final ActivityMoreMenuItemTyep type;
  ActivityMoreMenuItem({
    required this.title,
    required this.icon,
    required this.type,
  });

  static List<ActivityMoreMenuItem> values = [
    ActivityMoreMenuItem(
      title: 'Time Table',
      icon: Icons.schedule,
      type: ActivityMoreMenuItemTyep.timetable,
    ),
    ActivityMoreMenuItem(
      title: 'Events',
      icon: Icons.schedule,
      type: ActivityMoreMenuItemTyep.timetable,
    ),
    ActivityMoreMenuItem(
      title: 'Delete',
      icon: Icons.schedule,
      type: ActivityMoreMenuItemTyep.timetable,
    ),
  ];
}
*/