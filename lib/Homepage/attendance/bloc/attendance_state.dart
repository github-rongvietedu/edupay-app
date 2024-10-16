import 'package:equatable/equatable.dart';

import '../../../models/face_attendance_result.dart';
import '../../../models/student.dart';

enum AttendanceStatus { initial, changed, success, failure }

class AttendanceState extends Equatable {
  final Student student;
  final DateTime date;
  final AttendanceStatus status;
  final List<Attendance> listAttendance;
  final String message;
  @override
  List<Object> get props => [
        student,
        date,
        status,
        message,
      ];

  const AttendanceState(
      {required this.student,
      required this.date,
      required this.listAttendance,
      this.message = '',
      this.status = AttendanceStatus.initial});

  AttendanceState copyWith(
      {Student? student,
      DateTime? date,
      AttendanceStatus? status,
      List<Attendance>? listAttendance,
      String? message}) {
    return AttendanceState(
        student: this.student,
        date: this.date,
        status: status ?? this.status,
        listAttendance: listAttendance ?? this.listAttendance,
        message: message ?? this.message);
  }
}
