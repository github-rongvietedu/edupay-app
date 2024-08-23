import 'package:equatable/equatable.dart';

abstract class SchoolYearEvent extends Equatable {
  const SchoolYearEvent();
  @override
  List<Object> get props => [];
}

class ChangeSchoolYear extends SchoolYearEvent {
  final String schoolYearID;
  const ChangeSchoolYear(this.schoolYearID);
  @override
  List<Object> get props => [schoolYearID];
}

class LoadSchoolYear extends SchoolYearEvent {
  const LoadSchoolYear();
  @override
  List<Object> get props => [];
}
