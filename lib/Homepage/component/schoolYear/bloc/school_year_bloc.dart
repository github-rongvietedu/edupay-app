import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/networkservice.dart';
import '../../../../models/profile.dart';
import '../../../../models/schoolYear/school_year.dart';
import '../../../../models/schoolYear/school_year_result.dart';
import 'school_year_event.dart';
import 'school_year_state.dart';

class SchoolYearBloc extends Bloc<SchoolYearEvent, SchoolYearState> {
  final BuildContext context;
  final String companyCode;
  SchoolYearBloc(this.context, this.companyCode)
      : super(SchoolYearState(
            companyCode: companyCode,
            schoolYear: const [],
            currentSchoolYear: SchoolYear())) {
    on<LoadSchoolYear>(_onLoadSchoolYear);
    on<ChangeSchoolYear>(_onChangeSchoolYear);
  }
  void _onChangeSchoolYear(
      ChangeSchoolYear event, Emitter<SchoolYearState> emit) async {
    emit(state.copyWith(status: SchoolYearStatus.changed));
    if (event.schoolYearID != "") {
      emit(state.copyWith(
          currentSchoolYear:
              state.schoolYear.where((e) => e.iD == event.schoolYearID).first,
          status: SchoolYearStatus.success,
          message: "Lấy niên khoá thành công !!!"));
    } else {
      emit(state.copyWith(
          status: SchoolYearStatus.failure,
          message: "Lấy niên khoá thành công !!!"));
    }
  }

  void _onLoadSchoolYear(
      LoadSchoolYear event, Emitter<SchoolYearState> emit) async {
    emit(state.copyWith(status: SchoolYearStatus.changed));

    SchoolYearResult result = SchoolYearResult();
    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    // List<SchoolYearLessonDetail> listLesson = [];
    try {
      // listLesson =
      await NetworkService()
          .getAllSchoolYearV1(companyCode, Profile.currentStudent.id)
          .then((value) => result = value);

      // print("Ngày Điểm danh:" + event.date.toString());
      if (result.status == 2) {
        SchoolYear temp = SchoolYear();
        if (Profile.currentYear == "") {
          Profile.currentYear == result.schoolYear![0].iD;
          temp = result.schoolYear![0];
        } else {
          temp =
              state.schoolYear.where((e) => e.iD == Profile.currentYear).first;
        }
        emit(state.copyWith(
            schoolYear: result.schoolYear,
            currentSchoolYear: temp,
            status: SchoolYearStatus.success,
            message: "Lấy niên khoá thành công !!!"));
      } else {
        emit(state.copyWith(
            status: SchoolYearStatus.failure,
            message: "Lấy niên khoá thất bại!!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          status: SchoolYearStatus.failure,
          message: "Lấy niên khoá thất bại!!!"));
    }
  }
}
