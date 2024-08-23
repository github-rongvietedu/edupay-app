import 'package:equatable/equatable.dart';

import '../../../../models/classRoom/class_info.dart';
import '../../../../models/student.dart';

enum ClassStatus { initial, changed, success, failure }

class ClassState extends Equatable {
  final Student student;
  final ClassStatus status;
  final ClassInfo classInfo;
  // final List<ClassDetail> listClassDetail;
  final String message;
  @override
  List<Object> get props => [
        student,
        status,
        message,
      ];

  const ClassState(
      {required this.student,
      // required this.listClassDetail,
      required this.classInfo,
      this.message = '',
      this.status = ClassStatus.initial});

  ClassState copyWith(
      {Student? student,
      ClassStatus? status,
      ClassInfo? classInfo,
      String? message}) {
    return ClassState(
        student: this.student,
        status: status ?? this.status,
        classInfo: classInfo ?? this.classInfo,
        message: message ?? this.message);
  }
}
