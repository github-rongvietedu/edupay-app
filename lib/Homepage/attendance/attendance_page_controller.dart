import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/DataService.dart';
import '../../constants.dart';
import '../../core/base/base_view_view_model.dart';
import '../../models/face_attendance_result.dart';
import '../../models/profile.dart';
import '../../models/student.dart';

enum AttendanceStatus { initial, changed, success, failure }

class AttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendancePageController());
  }
}

class AttendancePageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  var attendanceStatus = AttendanceStatus.initial.obs;
  var listAttendance = <Attendance>[].obs;

  DateTime currentDate = Profile.currentDateAtten;
  DateTimeRange dateRange =
      DateTimeRange(start: Profile.firstDayOfWeek, end: Profile.lastDayOfWeek);

  @override
  void onInit() {
    super.onInit();
    loadAttendanceDateRange(
        firstDate: Profile.firstDayOfWeek,
        lastDate: Profile.lastDayOfWeek,
        student: Profile.currentStudent);
  }

  void loadAttendanceDateRange(
      {required DateTime firstDate,
      required DateTime lastDate,
      required Student student}) async {
    attendanceStatus(AttendanceStatus.changed);
    FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    // Simulate data fetch (Replace with actual API call)
    try {
      faceAttendaceResult = await DataService().faceAttendanceDateRange(
          "BTS-STD00000008",
          "BTS",
          DateTime(2021, 10, 13),
          DateTime(2024, 10, 15));

      if (faceAttendaceResult.status == 2) {
        Future.delayed(const Duration(seconds: 1), () {
          listAttendance.value = faceAttendaceResult.data!;
          attendanceStatus(AttendanceStatus.success);
        });
      } else {
        attendanceStatus(AttendanceStatus.failure);
      }
    } catch (ex) {
      attendanceStatus(AttendanceStatus.failure);
    }
  }

  // void loadAttendance(DateTime pickedDate, {required Student student}) {
  //   attendanceStatus(AttendanceStatus.changed);
  //   // Simulate data fetch
  //   Future.delayed(const Duration(seconds: 2), () {
  //     // Fake data assignment
  //     listAttendance.value = [/* Attendance items here */];
  //     attendanceStatus(AttendanceStatus.success);
  //   });
  // }

  Future pickDateRange() async {
    final picked = await showDateRangePicker(
      context: Get.context!,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            colorScheme: const ColorScheme.light(
              primary: kPrimaryColor,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? const Text(""),
        );
      },
      initialDateRange: dateRange,
      locale: const Locale('vi', ''),
      firstDate: DateTime(2019),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null) {
      dateRange = DateTimeRange(start: picked.start, end: picked.end);
      loadAttendanceDateRange(
          firstDate: picked.start,
          lastDate: picked.end,
          student: Profile.currentStudent);
    }
  }
}
