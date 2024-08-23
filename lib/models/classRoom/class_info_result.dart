import 'class_info.dart';

class ClassInfoResult {
  int? status;
  String? message;
  ClassInfo? data;
  ClassInfoResult({this.status, this.message, this.data});
  ClassInfoResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ClassInfo.fromJson(json['data']) : null;
  }
}
