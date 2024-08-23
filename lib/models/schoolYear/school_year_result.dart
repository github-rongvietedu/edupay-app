import 'school_year.dart';

class SchoolYearResult {
  int? status;
  String? message;
  int? total;
  List<SchoolYear>? schoolYear;
  SchoolYearResult({this.status, this.message, this.total, this.schoolYear});
  SchoolYearResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      schoolYear = <SchoolYear>[];
      json['data'].forEach((v) {
        schoolYear!.add(new SchoolYear.fromJson(v));
      });
    }
  }
}
