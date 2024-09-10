import 'package:equatable/equatable.dart';

import '../../../../models/classRoom/class_lesson_detail.dart';
import '../../../../models/student.dart';

enum LessonStatus { initial, changed, success, failure }

class LessonState extends Equatable {
  final LessonStatus status;

  final String? grade;
  final List<ClassLessonDetail> listLessonDetail;
  final String message;
  @override
  List<Object> get props => [
        status,
        message,
      ];

  const LessonState(
      {this.grade = '',
      required this.listLessonDetail,
      this.message = '',
      this.status = LessonStatus.initial});

  LessonState copyWith(
      {String? grade,
      DateTime? date,
      LessonStatus? status,
      List<ClassLessonDetail>? listLessonDetail,
      String? message}) {
    return LessonState(
        grade: grade ?? this.grade,
        status: status ?? this.status,
        listLessonDetail: listLessonDetail ?? this.listLessonDetail,
        message: message ?? this.message);
  }
}
