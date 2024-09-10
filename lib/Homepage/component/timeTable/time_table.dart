import 'package:edupay/Homepage/component/timeTable/bloc/time_table_event.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'dart:math' as math;

import '../../../models/TimeTable/time_table.dart';
import 'bloc/time_table_bloc.dart';
import 'bloc/time_table_state.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTableScreen>
    with TickerProviderStateMixin {
  late final TimeTableBloc _timeTableBloc;
  Map<int, String> dayOfWeek = {
    // 1: "THỨ HAI",
    // 2: "THỨ BA",
    // 3: "THỨ TƯ",
    // 4: "THỨ NĂM",
    // 5: "THỨ SÁU",
    // 6: "THỨ BẢY",
    // 7: "CHỦ NHẬT"
  };

  Map<int, Color> color = {
    0: Color(0xFFFF7F3F),
    1: Color(0xFFFF7777),
    2: Color(0xFFAAC4FF)
  };

  int selectedIndex = 0;
  int currentDateOfWeek = DateTime.now().weekday;
  DateTime currentDate = DateTime.now();
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    // if (currentDateOfWeek == 7) {
    //   currentDateOfWeek = currentDateOfWeek - 1;
    //   // currentDate = currentDate.subtract(const Duration(days: 1));
    // }
    _timeTableBloc = context.read<TimeTableBloc>()
      ..add(LoadTimeTable(dayWeek: currentDateOfWeek));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<TimeTableBloc, TimeTableState>(
      builder: (context, state) {
        if (state.scheduleDay.isNotEmpty) {
          tabController = TabController(
              initialIndex: currentDateOfWeek - 1,
              length: state.scheduleDay.length,
              vsync: this);
          tabController.addListener(() {
            selectedIndex = tabController.index;
            int dateChange = currentDateOfWeek - (selectedIndex + 1);
            if (dateChange > 0) {
              currentDate = currentDate.subtract(Duration(days: dateChange));
            } else if (dateChange < 0) {
              currentDate = currentDate.add(Duration(days: dateChange.abs()));
            }
            currentDateOfWeek = selectedIndex + 1;
            _timeTableBloc.add(ChangeTimeTable(dayWeek: currentDateOfWeek));
          });
        }
        switch (state.status) {
          case TimeTableStatus.failure:
            return Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Center(
                child: Container(
                    height: 120,
                    width: size.width,
                    child: Center(
                      child: Text('Chưa có thời khoá biểu ',
                          style: kTextStyleRowBlue),
                    )),
              ),
            );
            ;
          case TimeTableStatus.initial:
            break;
          case TimeTableStatus.changed:
            break;
          // return Center(
          //     child: Container(
          //         height: 50,
          //         width: 50,
          //         child: CircularProgressIndicator()));
          case TimeTableStatus.success:
            return buildListTimeTable(
                size, state.listDisplay, state.scheduleDay);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Column buildListTimeTable(
      Size size, List<TimeTable> listTimeTable, Map<int, String> dayOfWeek) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size.height * 0.065,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: PreferredSize(
                preferredSize: const Size.fromHeight(30.0),
                child: Center(
                  child: TabBar(
                      isScrollable: true,
                      unselectedLabelColor: Colors.black.withOpacity(0.8),
                      indicatorColor: kPrimaryColor,
                      labelColor: kPrimaryColor,
                      controller: tabController,
                      tabs: dayOfWeek.values
                          .map(
                            (e) => Tab(
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                          .toList()),
                )),
          ),
          Flexible(
              child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 10,
                        child: Center(
                          child: Text(
                              "${DateFormat("dd-MM-yyyy").format(currentDate)}",
                              style: kTextStyleTitleColor),
                        ),
                      ),
                      Flexible(
                        flex: 90,
                        child: listTimeTable.isEmpty
                            ? buildWidgetNotHasTimeTable()
                            : ListView.builder(
                                itemCount: listTimeTable.length,
                                itemBuilder: (context, index) {
                                  return buildTimeTable(
                                      size, listTimeTable, index);
                                }),
                      )
                    ],
                  )))
        ]);
  }

  Widget buildWidgetNotHasTimeTable() {
    Size size = MediaQuery.of(context).size;
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
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
            child: Column(
              children: [
                Image.asset(
                  'images/icon/bus_sleep.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Text(
                  "",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "",
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
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
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                  height: 50,
                  width: size.width,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.0),
                          bottomRight: Radius.circular(6.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              '${display[index].subjectName}',
                              maxLines: 2,
                              // textScaleFactor: 2,
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
                                    // textScaleFactor: 2,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
