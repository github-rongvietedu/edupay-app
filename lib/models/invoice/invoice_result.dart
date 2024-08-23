import 'invoice.dart';

class InvoiceResult {
  int? status;
  String? message;
  int? total;
  List<Invoice>? data;

  InvoiceResult({this.status, this.message, this.total, this.data});

  InvoiceResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Invoice>[];
      json['data'].forEach((v) {
        data!.add(Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
