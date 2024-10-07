import 'package:edupay/Homepage/component/timeTable/time_table_page_controller.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/base/base_view_view_model.dart';
import '../../../models/TimeTable/time_table.dart';

class TimeTablePage extends BaseView<TimeTableController> {
  // final controller controller = Get.put(controller());

  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (controller.scheduleDay.isNotEmpty) {
        controller.tabController = TabController(
            initialIndex: controller.currentDateOfWeek.value - 1,
            length: controller.scheduleDay.length,
            vsync: controller);

        controller.tabController.addListener(() {
          controller.selectedIndex.value = controller.tabController.index;
          controller.changeTimeTable(controller.selectedIndex.value);
        });
      }

      switch (controller.status.value) {
        case TimeTableStatus.failure:
          return Center(
            child: Text('Chưa có thời khoá biểu', style: kTextStyleRowBlue),
          );
        case TimeTableStatus.success:
          return buildListTimeTable(
              context, size, controller.listDisplay, controller.scheduleDay);
        default:
          return CircularProgressIndicator();
      }
    });
  }

  Column buildListTimeTable(context, Size size, List<TimeTable> listTimeTable,
      Map<int, String> dayOfWeek) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: size.height * 0.065,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Center(
            child: Obx(() => TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.black.withOpacity(0.8),
                  indicatorColor: kPrimaryColor,
                  labelColor: kPrimaryColor,
                  controller: controller.tabController,
                  tabs: dayOfWeek.values
                      .map((e) => Tab(
                          child: Text(e, style: const TextStyle(fontSize: 16))))
                      .toList(),
                )),
          ),
        ),
      ),
      Flexible(
          child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Flexible(
                    flex: 10,
                    child: Center(
                      child: Obx(() => Text(
                            "${DateFormat("dd-MM-yyyy").format(controller.currentDate.value)}",
                            style: kTextStyleTitleColor,
                          )),
                    ),
                  ),
                  Flexible(
                    flex: 90,
                    child: listTimeTable.isEmpty
                        ? buildWidgetNotHasTimeTable(context)
                        : ListView.builder(
                            itemCount: listTimeTable.length,
                            itemBuilder: (context, index) {
                              return buildTimeTable(size, listTimeTable, index);
                            }),
                  )
                ],
              ))),
    ]);
  }

  Widget buildWidgetNotHasTimeTable(context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Image.asset(
                'images/icon/bus_sleep.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text(
                "No schedule available",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  Container buildTimeTable(Size size, List<TimeTable> display, int index) {
    int countTypeMorning =
        display.where((element) => element.lessonType == 0).toList().length;
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          countTypeMorning == index
              ? Divider(thickness: 2, color: Color(0xFFFF7777))
              : SizedBox(),
          Row(
            children: [
              Flexible(
                  flex: 30,
                  child: Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${display[index].lessonName}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            )),
                        Text("${display[index].lessionTimeDescription}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14,
                            ))
                      ],
                    ),
                  )),
              Flexible(
                flex: 70,
                child: Container(
                  padding: EdgeInsets.only(left: 6.0),
                  margin: EdgeInsets.only(right: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: display[index].lessonType == 0
                          ? Color(0xFFAAC4FF)
                          : Color(0xFFFF7777),
                      boxShadow: [
                        BoxShadow(
                          color: display[index].lessonType == 0
                              ? Color(0xFFAAC4FF).withOpacity(0.5)
                              : Color(0xFFFF7777).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  height: 50,
                  width: size.width,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${display[index].subjectName}',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        display[index].teacherName != null
                            ? Flexible(
                                child: Text(
                                  '${display[index].teacherName ?? ""}',
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
