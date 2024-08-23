import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/networkservice.dart';
import '../../../../models/invoice/invoice.dart';
import '../../../../models/student.dart';
import 'invoice_event.dart';
import 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final BuildContext context;
  final Student student;
  InvoiceBloc(this.context, this.student)
      : super(InvoiceState(student: student, listInvoiceDetail: const [])) {
    on<LoadInvoice>(_onLoadInvoice);
  }
  void _onLoadInvoice(LoadInvoice event, Emitter<InvoiceState> emit) async {
    emit(state.copyWith(student: event.student, status: InvoiceStatus.changed));

    // FaceAttendanceResult faceAttendaceResult = FaceAttendanceResult();
    List<Invoice> listInvoice = [];
    try {
      // listInvoice =
      await NetworkService()
          .getAllInvoice(event.student.id)
          .then((value) => listInvoice = value.data!);

      if (listInvoice.isNotEmpty) {
        emit(state.copyWith(
            student: event.student,
            listInvoiceDetail: listInvoice,
            status: InvoiceStatus.success,
            message: "Lấy danh sách hoá đơn thành công !!!"));
      } else {
        emit(state.copyWith(
            student: event.student,
            status: InvoiceStatus.failure,
            message: "Lấy danh sách hoá đơn thất bại!!!"));
      }
    } catch (ex) {
      emit(state.copyWith(
          student: event.student,
          status: InvoiceStatus.failure,
          message: "Lấy danh sách hoá đơnthất bại!!!"));
    }
  }
}
