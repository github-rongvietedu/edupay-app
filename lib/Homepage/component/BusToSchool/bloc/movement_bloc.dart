import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/DataService.dart';
import '../../../../models/BusToSchool/movement.dart';
import 'movement_event.dart';
import 'movement_state.dart';

class MovementBloc extends Bloc<MovementEvent, MovementState> {
  final BuildContext context;
  MovementBloc(this.context) : super(MovementState(listMovement: const [])) {
    on<LoadMovement>(_onLoadMovement);
  }
  void _onLoadMovement(LoadMovement event, Emitter<MovementState> emit) async {
    emit(state.copyWith(status: MovementStatus.changed));

    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    List<Movement> listMovement = [];
    try {
      // listMovement =
      await DataService()
          .getAllMovementByParentPhone(
              event.phoneNumber, event.companyCode, event.date)
          .then((value) => listMovement = value);

      // print("Ngày Điểm danh:" + event.date.toString());

      if (listMovement.isNotEmpty) {
        emit(state.copyWith(
            listMovement: listMovement,
            status: MovementStatus.success,
            message: "Lấy danh sách xe thành công !!!"));
      } else {
        emit(state.copyWith(
            status: MovementStatus.failure,
            message: "Chưa đăng ký đưa đón học sinh!!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          status: MovementStatus.failure,
          message: "Chưa đăng ký đưa đón học sinh!!!"));
    }
  }
}
