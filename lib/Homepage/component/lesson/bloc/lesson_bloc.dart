import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/DataService.dart';
import '../../../../models/classRoom/class_lesson_detail.dart';
import '../../../../models/student.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final BuildContext context;
  final Student student;
  LessonBloc(this.context, this.student)
      : super(LessonState(student: student, listLessonDetail: const [])) {
    on<LoadLesson>(_onLoadLesson);
  }
  void _onLoadLesson(LoadLesson event, Emitter<LessonState> emit) async {
    emit(state.copyWith(student: event.student, status: LessonStatus.changed));

    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    List<ClassLessonDetail> listLesson = [];
    try {
      // listLesson =
      await NetworkService()
          .getLessonByStudentID(event.student.id)
          .then((value) => listLesson = value);

      // print("Ngày Điểm danh:" + event.date.toString());

      if (listLesson.isNotEmpty) {
        emit(state.copyWith(
            student: event.student,
            listLessonDetail: listLesson,
            status: LessonStatus.success,
            message: "Lấy danh sách giáo trình thành công !!!"));
      } else {
        emit(state.copyWith(
            student: event.student,
            status: LessonStatus.failure,
            message: "Lấy danh sách giáo trình thất bại!!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          student: event.student,
          status: LessonStatus.failure,
          message: "Lấy danh sách giáo trình thất bại!!!"));
    }
  }
}
