import 'package:equatable/equatable.dart';

import '../../../../models/schoolYear/school_year.dart';

enum SchoolYearStatus { initial, changed, success, failure }

class SchoolYearState extends Equatable {
  final String companyCode;
  final SchoolYearStatus status;
  final List<SchoolYear> schoolYear;
  final SchoolYear currentSchoolYear;
  // final List<SchoolYearDetail> listSchoolYearDetail;
  final String message;
  @override
  List<Object> get props => [
        companyCode,
        schoolYear,
        currentSchoolYear,
        status,
        message,
      ];

  const SchoolYearState(
      {required this.companyCode,
      required this.schoolYear,
      this.message = '',
      required this.currentSchoolYear,
      this.status = SchoolYearStatus.initial});

  SchoolYearState copyWith(
      {String? companyCode,
      SchoolYearStatus? status,
      List<SchoolYear>? schoolYear,
      SchoolYear? currentSchoolYear,
      String? message}) {
    return SchoolYearState(
        companyCode: companyCode ?? this.companyCode,
        status: status ?? this.status,
        schoolYear: schoolYear ?? this.schoolYear,
        currentSchoolYear: currentSchoolYear ?? this.currentSchoolYear,
        message: message ?? this.message);
  }
}
