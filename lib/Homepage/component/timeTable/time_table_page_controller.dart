import 'package:edupay/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:edupay/models/TimeTable/time_table.dart';
import 'package:flutter/material.dart';

enum TimeTableStatus { initial, changed, success, failure }

class TimeTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimeTableController());
  }
}

class TimeTableController extends BaseController
    with GetSingleTickerProviderStateMixin {
  var listDisplay = <TimeTable>[].obs;
  var scheduleDay = <int, String>{}.obs;
  var status = Rx<TimeTableStatus>(TimeTableStatus.initial);
  var selectedIndex = 0.obs;
  var currentDateOfWeek = DateTime.now().weekday.obs;
  var currentDate = DateTime.now().obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    loadTimeTable(currentDateOfWeek.value);
  }

  void loadTimeTable(int dayWeek) {
    // Simulate loading time table data (replace this with actual API calls)
    scheduleDay.value = {
      1: "THỨ HAI",
      2: "THỨ BA",
      3: "THỨ TƯ",
      4: "THỨ NĂM",
      5: "THỨ SÁU",
      6: "THỨ BẢY",
      7: "CHỦ NHẬT"
    };
    // Load data logic here
    status.value = TimeTableStatus.success;
    // Populate listDisplay based on the loaded timetable
  }

  void changeTimeTable(int index) {
    int dateChange = currentDateOfWeek.value - (index + 1);
    if (dateChange > 0) {
      currentDate.value =
          currentDate.value.subtract(Duration(days: dateChange));
    } else if (dateChange < 0) {
      currentDate.value =
          currentDate.value.add(Duration(days: dateChange.abs()));
    }
    currentDateOfWeek.value = index + 1;
  }
}
