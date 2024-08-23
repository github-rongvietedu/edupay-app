import 'package:intl/intl.dart';

class StudentLeaveOfAbsenceModel {
  // String? iD;
  String? companyCode;
  String? reasonDescription;
  String? fromDate;
  String? toDate;
  String? reason;
  String? student;
  String? parent;

  StudentLeaveOfAbsenceModel(
      {this.companyCode,
      this.reason,
      this.fromDate,
      this.reasonDescription,
      this.toDate,
      this.student,
      this.parent});

  Map<String, dynamic> toJson() {
    DateFormat dateFormat = DateFormat("yyyy/MM/dd");
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CompanyCode'] = this.companyCode;
    data['Reason'] = this.reason;
    data['FromDate'] = dateFormat.format(this.fromDate as DateTime);
    data['ToDate'] = this.toDate;
    data['Student'] = this.student;
    data['Parent'] = this.toDate;

    return data;
  }
}
