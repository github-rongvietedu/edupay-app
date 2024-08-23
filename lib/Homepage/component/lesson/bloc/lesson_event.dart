import 'package:equatable/equatable.dart';

import '../../../../models/student.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();
  @override
  List<Object> get props => [];
}

class LoadLesson extends LessonEvent {
  final Student student;
  // final DateTime date;

  const LoadLesson({required this.student});
  @override
  List<Object> get props => [student];
}
