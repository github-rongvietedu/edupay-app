import 'dart:math';

import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:darq/darq.dart';
import '../../../../config/DataService.dart';
import '../../../../models/TimeTable/time_table.dart';
import '../../../../models/student.dart';
import 'time_table_event.dart';
import 'time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final BuildContext context;
  TimeTableBloc(this.context)
      : super(TimeTableState(
            listDisplay: [], listTimeTable: [], scheduleDay: {})) {
    on<LoadTimeTable>(_onLoadTimeTable);
    on<ChangeTimeTable>(_onChangeTimeTable);
  }
  void _onChangeTimeTable(
      ChangeTimeTable event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(status: TimeTableStatus.changed));
    List<TimeTable> listTimeTable = state.listTimeTable;
    List<TimeTable> timeTableDisplay = [];
    try {
      listTimeTable.forEach((e) {
        if (e.scheduleDay == event.dayWeek) {
          timeTableDisplay.add(e);
        }
      });

      emit(state.copyWith(
          listDisplay: timeTableDisplay,
          status: TimeTableStatus.success,
          message: "Lấy danh sách giáo trình thành công."));
    } catch (ex) {
      emit(state.copyWith(
          status: TimeTableStatus.success,
          message: "Lấy danh sách giáo trình thành công."));
    }
  }

  void _onLoadTimeTable(
      LoadTimeTable event, Emitter<TimeTableState> emit) async {
    emit(state.copyWith(status: TimeTableStatus.changed));

    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    List<TimeTable> listTimeTable = [];
    Map<int, String> listScheduleDay = {
      1: "THỨ HAI",
      2: "THỨ BA",
      3: "THỨ TƯ",
      4: "THỨ NĂM",
      5: "THỨ SÁU",
      6: "THỨ BẢY",
      7: "CHỦ NHẬT"
    };
    List<TimeTable> timeTableDisplay = [];
    try {
      // listTimeTable =
      if (Profile.listTimeTable.isNotEmpty) {
        listTimeTable = Profile.listTimeTable;
      }
      // print("Ngày Điểm danh:" + event.date.toString());

      if (listTimeTable.isNotEmpty) {
        List<TimeTable> distinctList =
            listTimeTable.distinct((d) => d.scheduleDay as int).toList();
        // distinctList.forEach(((element) {
        //   listScheduleDay[element.scheduleDay as int] =
        //       element.scheduleDayName as String;
        // }));

        listTimeTable.forEach((e) {
          if (e.scheduleDay == event.dayWeek) {
            timeTableDisplay.add(e);
          }
        });

        emit(state.copyWith(
            listDisplay: timeTableDisplay,
            listTimeTable: listTimeTable,
            scheduleDay: listScheduleDay,
            status: TimeTableStatus.success,
            message: "Lấy danh sách giáo trình thành công."));
      } else {
        emit(state.copyWith(
            status: TimeTableStatus.failure,
            message: "Chưa có thời khoá biểu."));
      }
    } catch (ex) {
      print(ex);
      emit(state.copyWith(
          status: TimeTableStatus.failure,
          message: "Lấy thời khoá biểu thất bại !!!"));
    }
  }
}
