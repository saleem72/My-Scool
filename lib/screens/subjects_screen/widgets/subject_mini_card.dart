//

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_school/styling/pallet.dart';

import '../../../blocs/cubit/school_database_cubit.dart';
import '../../../database/database_models.dart';
import '../../../database/school_database.dart';

enum SubjectMiniCardDropItem { addBranch, delete }

extension SubjectMiniCardDropItemDetails on SubjectMiniCardDropItem {
  String get title {
    switch (this) {
      case SubjectMiniCardDropItem.addBranch:
        return 'Add Brach';
      case SubjectMiniCardDropItem.delete:
        return 'Delete';
    }
  }

  IconData get icon {
    switch (this) {
      case SubjectMiniCardDropItem.addBranch:
        return Icons.add;
      case SubjectMiniCardDropItem.delete:
        return Icons.delete;
    }
  }
}

class SubjectMiniCard extends StatelessWidget {
  const SubjectMiniCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubjectWithBranchs item;

  _saveEntry(BuildContext context, SubjectsCompanion model) {
    final database = context.read<SchoolDatabaseCubit>().database;
    database.subjectsDao.insertSubject(model);
  }

  _showAddSubject(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CraetePublicSubjectBranchDialog(
          parentId: item.subject.id,
          onSave: (model) {
            _saveEntry(context, model);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Pallet.grey,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.subject.title,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Pallet.darkBlue,
                      ),
                ),
                _contextMenu(context),
              ],
            ),
            Row(
              children: [
                Text(
                  'Has Dectation: ',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Switch(value: item.subject.hasDictation, onChanged: (_) {}),
              ],
            ),
            Row(
              children: [
                Text(
                  'Has Exams: ',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Switch(value: item.subject.hasExams, onChanged: (_) {}),
              ],
            ),
            item.branchs.isNotEmpty ? const Divider() : const SizedBox.shrink(),
            item.branchs.isNotEmpty
                ? _branchs(context)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _actionFor(BuildContext context,
      {required SubjectMiniCardDropItem item}) {
    switch (item) {
      case SubjectMiniCardDropItem.addBranch:
        _showAddSubject(context);
        break;
      case SubjectMiniCardDropItem.delete:
        break;
    }
  }

  Widget _contextMenu(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      icon: const Icon(Icons.more_vert),
      onSelected: (item) => _actionFor(context, item: item),
      itemBuilder: (context) => SubjectMiniCardDropItem.values
          .map((e) => PopupMenuItem(
                value: e,
                child: Row(
                  children: [
                    Icon(
                      e.icon,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      e.title,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _branchs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item.branchs.asMap().entries.map((e) {
          final item = e.value;
          final index = (e.key + 1).toString();
          return _SubjectBranchRow(index: index, item: item);
        }).toList(),
      ),
    );
  }
}

class _SubjectBranchRow extends StatelessWidget {
  const _SubjectBranchRow({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  final String index;
  final Subject item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$index:',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontSize: 17,
              ),
        ),
        const SizedBox(width: 16),
        Text(
          item.title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                // fontSize: 17,
                color: Pallet.darkBlue,
              ),
        ),
        Expanded(child: Container()),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.error,
            size: 16,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit,
            size: 16,
          ),
        ),
      ],
    );
  }
}

class CraetePublicSubjectBranchDialog extends StatefulWidget {
  const CraetePublicSubjectBranchDialog({
    Key? key,
    required this.parentId,
    required this.onSave,
  }) : super(key: key);

  final int parentId;
  final Function(SubjectsCompanion) onSave;
  @override
  State<CraetePublicSubjectBranchDialog> createState() =>
      _CraetePublicSubjectBranchDialogState();
}

class _CraetePublicSubjectBranchDialogState
    extends State<CraetePublicSubjectBranchDialog> {
  final TextEditingController subjectName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: Text(
        "Add subject",
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: subjectName,
              autofocus: true,
              decoration: const InputDecoration(
                isCollapsed: true,
                hintText: 'Subject name',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            }),
        TextButton(
            child: const Text('SAVE'),
            onPressed: () {
              final model = SubjectsCompanion.insert(
                title: subjectName.text,
                parentId: drift.Value(widget.parentId),
              );
              widget.onSave(model);
              Navigator.pop(context, 'Save');
            }),
      ],
    );
  }
}
