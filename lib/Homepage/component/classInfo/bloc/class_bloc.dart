import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/DataService.dart';
import '../../../../models/classRoom/class_info.dart';
import '../../../../models/classRoom/class_info_result.dart';
import '../../../../models/student.dart';
import 'class_event.dart';
import 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final BuildContext context;
  final Student student;
  ClassBloc(this.context, this.student)
      : super(ClassState(student: student, classInfo: ClassInfo())) {
    on<LoadClass>(_onLoadClass);
  }
  void _onLoadClass(LoadClass event, Emitter<ClassState> emit) async {
    emit(state.copyWith(student: event.student, status: ClassStatus.changed));

    ClassInfoResult result = ClassInfoResult();
    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    // List<ClassLessonDetail> listLesson = [];
    try {
      // listLesson =
      await DataService()
          .getClassInfo(
              event.student.companyCode, event.student.id, event.schoolYearID)
          .then((value) => result = value);

      // print("Ngày Điểm danh:" + event.date.toString());

      if (result.status == 2) {
        Profile.currentClassRoom = result.data!;
        // ClassInfo.fromJson(result.data as Map<String, dynamic>);
        emit(state.copyWith(
            student: event.student,
            classInfo: result.data,
            status: ClassStatus.success,
            message: "Lấy thông tin lớp thành công !!!"));
      } else {
        emit(state.copyWith(
            student: event.student,
            status: ClassStatus.failure,
            message: "Lấy thông tin lớp thất bại!!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          student: event.student,
          status: ClassStatus.failure,
          message: "Lấy thông tin lớp thất bại!!!"));
    }
  }
}
