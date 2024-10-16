import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../core/base/base_view_view_model.dart';
import '../../models/classRoom/class_lesson_detail.dart';
import 'lesson_controller.dart'; // Import your LessonController

class LessonPage extends BaseView<LessonController> {
  LessonPage({super.key});
  DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");

  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                  const SizedBox(
                    width: 8,
                  ),
                  Text("Giáo trình:", style: kTextStyleTitle),
                  const Spacer(),
                ],
              ),
            ),
            Obx(() {
              switch (controller.status.value) {
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
                            child: Text('Chưa có thông tin bài giảng ',
                                style: kTextStyleRowBlue),
                          )),
                    ),
                  );
                case LessonStatus.success:
                  // Add your success state UI here
                  return Container(); // Replace with actual UI
                case LessonStatus.loading:
                default:
                  return Center(child: CircularProgressIndicator());
              }
            }),
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
