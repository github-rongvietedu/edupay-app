import 'package:equatable/equatable.dart';

import '../../../../models/student.dart';

abstract class TimeTableEvent extends Equatable {
  const TimeTableEvent();
  @override
  List<Object> get props => [];
}

class ChangeTimeTable extends TimeTableEvent {
  final int dayWeek;
  const ChangeTimeTable({required this.dayWeek});
  @override
  List<Object> get props => [dayWeek];
}

class LoadTimeTable extends TimeTableEvent {
  final int dayWeek;
  const LoadTimeTable({required this.dayWeek});
  @override
  List<Object> get props => [dayWeek];
}
