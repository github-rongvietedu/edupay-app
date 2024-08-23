import 'package:equatable/equatable.dart';

import '../../../../models/student.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();
  @override
  List<Object> get props => [];
}

class LoadClass extends ClassEvent {
  final Student student;
  final String schoolYearID;
  // final DateTime date;

  const LoadClass(this.schoolYearID, {required this.student});
  @override
  List<Object> get props => [student];
}
