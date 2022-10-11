//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_school/styling/constants.dart';
import 'package:my_school/styling/pallet.dart';

import '../../../database/database_models.dart';
import '../../../database/school_database.dart';
import '../student_time_table_cubit/student_time_table_cubit.dart';

class TimeTableCell extends StatefulWidget {
  const TimeTableCell({
    Key? key,
    required this.cell,
    required this.cellWidth,
    required this.cellHeight,
    required this.hasBottomBorder,
  }) : super(key: key);
  final GeneralClass cell;
  final double cellWidth;
  final double cellHeight;
  final bool hasBottomBorder;

  @override
  State<TimeTableCell> createState() => _TimeTableCellState();
}

class _TimeTableCellState extends State<TimeTableCell> {
  void _createClass(StudentTimeTableCubit cubit, Subject value) {
    final subjectId = int.parse(value.id.toString());
    cubit.onActiveCellSave(
        cell: widget.cell,
        model: StudentClassesCompanion.insert(
            studentId: cubit.studentId,
            subjectId: subjectId,
            dayId: widget.cell.dayId,
            order: widget.cell.order));
  }

  Widget _popMenu(BuildContext context,
      {required StudentTimeTableCubit cubit,
      required SubjectWithBranchs item}) {
    return item.branchs.isEmpty
        ? Container()
        : PopupMenuButton<Subject>(
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onCanceled: () {
              // if (Navigator.canPop(context)) {
              //   Navigator.pop(context);
              //   if (Navigator.canPop(context)) {
              //     Navigator.pop(context);
              //   }
              // }
            },
            // how much the submenu should offset from parent. This seems to have an upper limit.
            offset: const Offset(300, 0),
            onSelected: (value) {
              _createClass(cubit, value);
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            itemBuilder: (context) => item.branchs
                .map((e) =>
                    PopupMenuItem<Subject>(value: e, child: Text(e.title)))
                .toList()
              ..insert(
                  0,
                  PopupMenuItem<Subject>(
                      value: item.subject, child: Text(item.subject.title))),
            child: Text(item.subject.title),
          );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentTimeTableCubit>();
    return BlocBuilder<StudentTimeTableCubit, TimetableActiveCell?>(
      builder: (context, state) {
        return Container(
          width: widget.cellWidth,
          height: widget.cellHeight,
          constraints: BoxConstraints(
            maxWidth: widget.cellWidth,
          ),
          decoration: BoxDecoration(
            border: _getBorder(widget.cell.order),
            color: Pallet.tableBody,
          ),
          alignment: Alignment.center,
          child: cubit.subjects.isEmpty
              ? Container()
              : PopupMenuButton<Subject>(
                  // padding: const EdgeInsets.symmetric(horizontal: 14),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12)),
                  child: _subject(context),
                  onSelected: (value) => _createClass(cubit, value),
                  itemBuilder: (context) => cubit.subjects
                      .map((e) => PopupMenuItem<Subject>(
                            value: e.subject,
                            child: e.branchs.isEmpty
                                ? Text(e.subject.title)
                                : _popMenu(
                                    context,
                                    cubit: cubit,
                                    item: e,
                                  ),
                          ))
                      .toList(),
                ),
        );
      },
    );
  }

  Widget _dropdownButton(StudentTimeTableCubit cubit) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Subject>(
        value: widget.cell.subject,
        items: cubit.subjects
            .map((e) => DropdownMenuItem<Subject>(
                  value: e.subject,
                  child: Text(e.subject.title),
                  // child: (e.branchs.isEmpty)
                  //     ? Text(e.title)
                  //     : _popMenu(context,
                  //         cubit: cubit,
                  //         subject: e,
                  //         items: e.branchs),
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _subject(BuildContext context) {
    return widget.cell.subject?.title == null
        ? const Text(
            'Choose',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          )
        : Text(widget.cell.subject!.title);
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Border _getBorder(int index) {
    return Border(
      left: const BorderSide(
        width: 1,
        color: Colors.white,
      ),
      top: const BorderSide(
        width: 1,
        color: Colors.white,
      ),
      bottom: widget.hasBottomBorder
          ? const BorderSide(color: Colors.white)
          : BorderSide.none,
      right: index == Constants.classesCount
          ? const BorderSide(width: 1, color: Colors.white)
          : BorderSide.none,
    );
  }
}
