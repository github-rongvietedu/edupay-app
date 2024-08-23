import 'package:equatable/equatable.dart';

import '../../../../models/TimeTable/time_table.dart';
import '../../../../models/student.dart';

enum TimeTableStatus { initial, changed, success, failure }

class TimeTableState extends Equatable {
  final TimeTableStatus status;
  final Map<int, String> scheduleDay;
  final List<TimeTable> listTimeTable;
  final List<TimeTable> listDisplay;
  final String message;
  @override
  List<Object> get props => [
        scheduleDay,
        listTimeTable,
        listDisplay,
        status,
        message,
      ];

  const TimeTableState(
      {required this.listDisplay,
      required this.listTimeTable,
      required this.scheduleDay,
      this.message = '',
      this.status = TimeTableStatus.initial});

  TimeTableState copyWith(
      {Map<int, String>? scheduleDay,
      List<TimeTable>? listTimeTable,
      List<TimeTable>? listDisplay,
      TimeTableStatus? status,
      String? message}) {
    return TimeTableState(
        scheduleDay: scheduleDay ?? this.scheduleDay,
        listTimeTable: listTimeTable ?? this.listTimeTable,
        listDisplay: listDisplay ?? this.listDisplay,
        status: status ?? this.status,

        // listTimeTableDetail: listTimeTableDetail ?? this.listTimeTableDetail,
        message: message ?? this.message);
  }
}
