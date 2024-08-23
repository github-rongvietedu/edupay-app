import 'package:equatable/equatable.dart';

import '../../../../models/student.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
  @override
  List<Object> get props => [];
}

class LoadAttendance extends AttendanceEvent {
  final Student student;
  final DateTime date;

  const LoadAttendance(this.date, {required this.student});
  @override
  List<Object> get props => [student, date];
}

class LoadAttendanceDateRange extends AttendanceEvent {
  final Student student;
  final DateTime firstDate;
  final DateTime lastDate;

  const LoadAttendanceDateRange(
      {required this.firstDate, required this.lastDate, required this.student});
  @override
  List<Object> get props => [student, firstDate, lastDate];
}
