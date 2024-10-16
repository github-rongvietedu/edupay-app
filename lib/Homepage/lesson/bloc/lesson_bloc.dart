import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/DataService.dart';
import '../../../models/classRoom/class_lesson_detail.dart';
import '../../../models/student.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final BuildContext context;
  final String grade;
  LessonBloc(this.context, this.grade)
      : super(LessonState(grade: grade, listLessonDetail: const [])) {
    on<LoadLesson>(_onLoadLesson);
  }
  void _onLoadLesson(LoadLesson event, Emitter<LessonState> emit) async {
    emit(state.copyWith(grade: event.grade, status: LessonStatus.changed));

    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    List<ClassLessonDetail> listLesson = [];
    try {
      // listLesson =
      await DataService()
          .getAllLessonByGrade(event.grade)
          .then((value) => listLesson = value);

      // print("Ngày Điểm danh:" + event.date.toString());

      if (listLesson.isNotEmpty) {
        emit(state.copyWith(
            grade: event.grade,
            listLessonDetail: listLesson,
            status: LessonStatus.success,
            message: "Lấy danh sách giáo trình thành công !!!"));
      } else {
        emit(state.copyWith(
            grade: event.grade,
            status: LessonStatus.failure,
            message: "Lấy danh sách giáo trình thất bại!!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          grade: event.grade,
          status: LessonStatus.failure,
          message: "Lấy danh sách giáo trình thất bại!!!"));
    }
  }
}
