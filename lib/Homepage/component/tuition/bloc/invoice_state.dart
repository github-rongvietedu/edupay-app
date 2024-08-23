import 'package:equatable/equatable.dart';

import '../../../../models/invoice/invoice.dart';
import '../../../../models/student.dart';

enum InvoiceStatus { initial, changed, success, failure }

class InvoiceState extends Equatable {
  final Student student;
  final InvoiceStatus status;
  final List<Invoice> listInvoiceDetail;
  final String message;
  @override
  List<Object> get props => [
        student,
        status,
        message,
      ];

  const InvoiceState(
      {required this.student,
      required this.listInvoiceDetail,
      this.message = '',
      this.status = InvoiceStatus.initial});

  InvoiceState copyWith(
      {Student? student,
      DateTime? date,
      InvoiceStatus? status,
      List<Invoice>? listInvoiceDetail,
      String? message}) {
    return InvoiceState(
        student: this.student,
        status: status ?? this.status,
        listInvoiceDetail: listInvoiceDetail ?? this.listInvoiceDetail,
        message: message ?? this.message);
  }
}
