import 'movement.dart';

class ResultMovement {
  int? status;
  String? message;
  int? total;
  List<Movement>? data;

  ResultMovement({this.status, this.message, this.total, this.data});
  ResultMovement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Movement>[];
      json['data'].forEach((v) {
        data!.add(Movement.fromJson(v));
      });
    }
  }
}
