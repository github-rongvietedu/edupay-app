import 'package:equatable/equatable.dart';

import '../../../../models/classRoom/class_lesson_detail.dart';
import '../../../../models/student.dart';

enum LessonStatus { initial, changed, success, failure }

class LessonState extends Equatable {
  final Student student;

  final LessonStatus status;
  final List<ClassLessonDetail> listLessonDetail;
  final String message;
  @override
  List<Object> get props => [
        student,
        status,
        message,
      ];

  const LessonState(
      {required this.student,
      required this.listLessonDetail,
      this.message = '',
      this.status = LessonStatus.initial});

  LessonState copyWith(
      {Student? student,
      DateTime? date,
      LessonStatus? status,
      List<ClassLessonDetail>? listLessonDetail,
      String? message}) {
    return LessonState(
        student: this.student,
        status: status ?? this.status,
        listLessonDetail: listLessonDetail ?? this.listLessonDetail,
        message: message ?? this.message);
  }
}
