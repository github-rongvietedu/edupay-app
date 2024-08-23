import 'package:equatable/equatable.dart';

import '../../../../models/student.dart';

abstract class InvoiceEvent extends Equatable {
  const InvoiceEvent();
  @override
  List<Object> get props => [];
}

class LoadInvoice extends InvoiceEvent {
  final Student student;
  // final DateTime date;

  const LoadInvoice({required this.student});
  @override
  List<Object> get props => [student];
}
