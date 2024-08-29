import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/DataService.dart';
import '../../../../models/face_attendance_result.dart';
import '../../../../models/student.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final BuildContext context;
  final Student student;
  final DateTime date;
  AttendanceBloc(this.context, this.student, this.date)
      : super(AttendanceState(
            student: student, date: date, listAttendance: const [])) {
    on<LoadAttendance>(_onLoadAttendance);
    on<LoadAttendanceDateRange>(_onLoadAttendanceDateRange);
  }
  void _onLoadAttendance(
      LoadAttendance event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(
        student: event.student,
        date: event.date,
        status: AttendanceStatus.changed));

    FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    try {
      faceAttendaceResult = await DataService().faceAttendance(
          event.student.studentCode, event.student.companyCode, event.date);

      print("Ngày Điểm danh:" + event.date.toString());
      if (faceAttendaceResult.status == 2) {
        emit(state.copyWith(
            listAttendance: faceAttendaceResult.data,
            date: event.date,
            status: AttendanceStatus.success,
            message: "Lấy danh sách điểm danh thành công !!!"));
      } else {
        emit(state.copyWith(
            status: AttendanceStatus.failure,
            date: event.date,
            message: "Lấy danh sách điểm danh thất bại !!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          status: AttendanceStatus.failure,
          date: event.date,
          message: "Lấy danh sách điểm danh thất bại !!!"));
    }
  }

  void _onLoadAttendanceDateRange(
      LoadAttendanceDateRange event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(
        student: event.student,
        // date: event.date,
        status: AttendanceStatus.changed));

    FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    try {
      faceAttendaceResult = await DataService().faceAttendanceDateRange(
          event.student.studentCode,
          event.student.companyCode,
          event.firstDate,
          event.lastDate);

      if (faceAttendaceResult.status == 2) {
        emit(state.copyWith(
            listAttendance: faceAttendaceResult.data,
            status: AttendanceStatus.success,
            message: "Lấy danh sách điểm danh thành công !!!"));
      } else {
        emit(state.copyWith(
            status: AttendanceStatus.failure,
            message: "Lấy danh sách điểm danh thất bại !!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          status: AttendanceStatus.failure,
          message: "Lấy danh sách điểm danh thất bại !!!"));
    }
  }
}
