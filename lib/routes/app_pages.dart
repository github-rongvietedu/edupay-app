import 'package:edupay/HomePageTeacher/AttendanceStudent/attendance_menu_page.dart';
import 'package:edupay/Homepage/attendance/attendance_page.dart';
import 'package:edupay/Homepage/attendance/attendance_page_controller.dart';
import 'package:edupay/Homepage/foodMenu/menu_week.dart';
import 'package:edupay/Login/login.dart';
import 'package:edupay/Welcome/welcome_page.dart';
import 'package:edupay/Welcome/welcome_page_controller.dart';
import 'package:edupay/leave_application.dart';
import 'package:edupay/models/foodmenu/foodmenu.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../HomePageTeacher/AttendanceStudent/attendance_menu_controller.dart';
import '../HomePageTeacher/AttendanceStudent/quick_attendance_student_controller.dart';
import '../HomePageTeacher/AttendanceStudent/quick_attendance_student_page.dart';
import '../Homepage/component/timeTable/time_table_page.dart';
import '../Homepage/component/timeTable/time_table_page_controller.dart';
import '../Homepage/home_page_parent.dart';
import '../Homepage/home_page_parent_controller.dart';
import '../Homepage/tuition/tuition_fee_page.dart';
import '../Homepage/tuition/tuition_fee_page_controller.dart';
import '../Login/login_page.dart';
import '../Login/login_page_controller.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.HOMEPAGEPARENT,
      page: () => HomePageParent(),
      binding: HomePageParentBinding(),
    ),
    GetPage(
      name: Routes.FOODMENU,
      page: () => const MenuWeek(),
    ),
    GetPage(
        name: Routes.TIMETABLE,
        page: () => TimeTablePage(),
        binding: TimeTableBinding()),
    GetPage(
        name: Routes.ATTENDANCE,
        page: () => AttendancePage(),
        binding: AttendanceBinding()),
    GetPage(
      name: Routes.LEAVEAPPLICATION,
      page: () => LeaveApplicationScreen(),
    ),
    GetPage(
      name: Routes.TUITION,
      page: () => TuitionFeePage(),
      binding: TuitionFeePageBinding(),
    ),
    GetPage(
      name: Routes.QUICKATTENDANCESTUDENT,
      page: () => QuickAttendanceStudentPage(),
      binding: QuickAttendanceStudentBinding(),
    ),
    GetPage(
      name: Routes.ATTENDANCEMENU,
      page: () => AttendanceMenuPage(),
      binding: AttendanceMenuBinding(),
    ),

    ///
  ];
}
