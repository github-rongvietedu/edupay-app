import 'package:edupay/models/loginModel/employee_model.dart';

import '../student.dart';

class LoginModelResult {
  String? parent;
  int? status;
  String? message;
  String? fullName;
  String? deviceID;
  String? phoneNumber;
  String? employeeCode;
  List<Student>? listStudent;
  Employee? employeeInfo;
  LoginModelResult(
      {this.parent,
      this.status,
      this.message,
      this.deviceID,
      this.fullName,
      this.phoneNumber,
      this.listStudent,
      this.employeeCode,
      this.employeeInfo});

  factory LoginModelResult.fromJson(Map<String, dynamic> json) {
    LoginModelResult loginModel = LoginModelResult();
    loginModel.status = json['status'];
    loginModel.message = json['message'];
    loginModel.fullName = json['FullName'];
    loginModel.deviceID = json['DeviceID'];
    loginModel.phoneNumber = json['PhoneNumber'];
    loginModel.parent = json['Parent'] ?? "";
    loginModel.employeeCode = json['EmployeeCode'] ?? "";
    try {
      loginModel.employeeInfo = Employee.fromJson(json['EmployeeInfo']);
    } catch (ex) {}

    try {
      loginModel.listStudent = [];
      for (var student in json['LstStudent']) {
        loginModel.listStudent!.add(Student.fromJson(student));
      }
    } catch (ex) {}

    return loginModel;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "accessToken": fullName,
        "DeviceID": deviceID,
        "PhoneNumber": phoneNumber,
        "ListStudent": listStudent
      };
}
