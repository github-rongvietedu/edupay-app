import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../config/DataService.dart';
import '../../../constants.dart';
import '../../../models/classRoom/class_lesson_detail.dart';
import '../../../models/profile.dart';
import '../../../models/student.dart';
import '../attendance/bloc/attendance_bloc.dart';
import 'bloc/lesson_bloc.dart';
import 'bloc/lesson_event.dart';
import 'bloc/lesson_state.dart';

class LessonScreenV2 extends StatefulWidget {
  const LessonScreenV2({Key? key, this.student}) : super(key: key);
  final Student? student;
  @override
  _LessonScreenV2State createState() => _LessonScreenV2State();
}

class _LessonScreenV2State extends State<LessonScreenV2>
    with TickerProviderStateMixin {
  late Student? student;
  DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
  late LessonBloc _lessonBloc;
  @override
  void initState() {
    super.initState();
    _lessonBloc = context.read<LessonBloc>()
      ..add(LoadLesson(grade: Profile.currentClassRoom.gradeCode));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LessonBloc, LessonState>(
      listener: (context, state) {
        switch (state.status) {
          case LessonStatus.failure:
            // _showSnackBar(context, state.message, Colors.red);
            break;
          case LessonStatus.initial:
            // TODO: Handle this case.
            break;
          case LessonStatus.changed:
            // TODO: Handle this case.
            break;
          case LessonStatus.success:
            // TODO: Handle this case.
            break;
        }
      },
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.70,

              // color: kPrimaryColor
            ),
            ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height * 0.1,
                  minWidth: size.width,
                  maxHeight: double.infinity,
                ),
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 1,
                    ),
                    height: size.height * 0.73,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4)),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 40,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Icon(Icons.person, size: 30, color: Colors.grey[500]),
                                  const SizedBox(
                                    width: 8,
                                  ),

                                  Text("Giáo trình:", style: kTextStyleTitle),
                                  const Spacer(),
                                  // const Icon(Icons.calendar_month,
                                  //     size: 36, color: Colors.blue),
                                ],
                              ),
                            ),
                            BlocBuilder<LessonBloc, LessonState>(
                                builder: (context, state) {
                              // do stuff here based on BlocA's state

                              switch (state.status) {
                                case LessonStatus.failure:
                                  return Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Center(
                                      child: Container(
                                          height: 100,
                                          width: size.width,
                                          child: Center(
                                            child: Text(
                                                'Chưa có thông tin bài giảng ',
                                                style: kTextStyleRowBlue),
                                          )),
                                    ),
                                  );

                                case LessonStatus.initial:
                                  break;
                                case LessonStatus.changed:
                                  return Center(
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator()));

                                case LessonStatus.success:
                                  return state.listLessonDetail.isNotEmpty
                                      ? Flexible(
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  state.listLessonDetail.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return buildWidgetLesson(
                                                    size,
                                                    state.listLessonDetail,
                                                    index);
                                              }),
                                        )
                                      : buildWidgetNotLesson(size);
                              }
                              return Center(
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      child: CircularProgressIndicator()));
                            }),
                          ]),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget buildWidgetNotLesson(Size size) {
    DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 140,
          minWidth: size.width,
          maxHeight: double.infinity,
        ),
        child: Container(
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
            child: Text("Giáo trình chưa được cập nhật !!!")),
      ),
    );
  }

  Card buildWidgetLesson(Size size, List<ClassLessonDetail> Lesson, int index) {
    DateFormat dateFormat = DateFormat("hh:mm - dd/MM/yyyy");

    return Card(
      color: Colors.white,
      elevation: 2,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 140,
          minWidth: size.width,
          maxHeight: double.infinity,
        ),
        child: Container(
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Từ ngày ${dateFormatDay.format(Lesson[index].startDate ?? DateTime.now())} đến ngày ${dateFormatDay.format(Lesson[index].endDate ?? DateTime.now())} ",
                    style: kTextStyleTable),
                Text(Lesson[index].lessonName ?? '', style: kTextStyleNomal),
                Text(Lesson[index].content ?? '', style: kTextStyleNomal)
              ],
            )),
      ),
    );
  }
}

//
void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(seconds: 3));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
