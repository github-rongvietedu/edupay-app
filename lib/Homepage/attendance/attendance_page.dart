import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../core/base/base_view_view_model.dart';
import '../../models/face_attendance_result.dart';
import '../../models/profile.dart';
import 'attendance_page_controller.dart';
import 'detail_attendance.dart';

class AttendancePage extends BaseView<AttendancePageController> {
  // final controller controller = Get.put(controller());

  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          title: Text("Điểm danh"),
          centerTitle: true),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size.height * 0.1,
          minWidth: size.width,
          maxHeight: double.infinity,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  controller.pickDateRange();
                },
                child: Container(
                  height: 40,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      Text("Điểm danh:", style: kTextStyleTitle),
                      const Spacer(),
                      const Icon(Icons.calendar_month,
                          size: 36, color: Colors.blue),
                    ],
                  ),
                ),
              ),
              Obx(() {
                switch (controller.attendanceStatus.value) {
                  case AttendanceStatus.failure:
                    return Center(child: Text('Failed to fetch Attendance'));
                  case AttendanceStatus.initial:
                  case AttendanceStatus.changed:
                    return Center(
                        child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()));
                  case AttendanceStatus.success:
                    return controller.listAttendance.isNotEmpty
                        ? Flexible(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.listAttendance.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildWidgetAttendance(
                                      size, controller.listAttendance, index);
                                }),
                          )
                        : buildWidgetNotAttendance(size);
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWidgetNotAttendance(Size size) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${dateFormatDay.format(Profile.firstDayOfWeek)} - ${dateFormatDay.format(Profile.lastDayOfWeek)}",
                  style: kTextStyleTitleColor),
              _textWithSpace("Tình trạng:", "Chưa điểm danh", 5, 5),
            ],
          ),
        ),
      ),
    );
  }

  Row _textWithSpace(String text1, String text2, int flex1, int flex2) {
    return Row(
      children: [
        Flexible(
          flex: flex1,
          child: Container(
            width: MediaQuery.of(Get.context!).size.width,
            child: Text(
              text1,
              overflow: TextOverflow.ellipsis,
              style: kTextStyleNomalBrown,
            ),
          ),
        ),
        Flexible(
          flex: flex2,
          child: Container(
            width: MediaQuery.of(Get.context!).size.width,
            child: Text(
              text2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: kTextStyleBold,
            ),
          ),
        )
      ],
    );
  }

  Widget buildWidgetAttendance(
      Size size, List<Attendance> attendance, int index) {
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    DateFormat dateFormatDay = DateFormat("dd/MM/yyyy");
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailAttendance(
              attendance: attendance[index],
            ));
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 130,
            minWidth: size.width,
            maxHeight: double.infinity,
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 12, bottom: 8, right: 12),
            child: Row(
              children: [
                Flexible(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateFormatDay.format(
                            attendance[index].captureAt ?? DateTime.now()),
                        style: kTextStyleTitleColor,
                      ),
                      _textWithSpace(
                        "Giờ điểm danh:",
                        dateFormat.format(
                            attendance[index].captureAt ?? DateTime.now()),
                        5,
                        5,
                      ),
                      _textWithSpace(
                          "Vị trí:", attendance[index].deviceName ?? "", 5, 5),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: attendance == null
                        ? Image.asset('images/noimage.jpg')
                        : Image.network(
                            attendance[index].uRLCaptureImage,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset('images/noimage.jpg');
                            },
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
