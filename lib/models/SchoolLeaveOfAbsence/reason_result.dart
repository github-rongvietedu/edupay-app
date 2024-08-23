import '../result.dart';
import 'reason.dart';

class ReasonResult {
  int? status;
  String? message;
  List<Reason>? data;

  ReasonResult({this.status, this.message, this.data});

  ReasonResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(Reason.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
