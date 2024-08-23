import 'package:bts_app/models/loginModel/employee_model.dart';

import '../student.dart';

class LoginModelResult {
  String? parent;
  bool? loginStatus;
  String? message;
  String? fullName;
  String? deviceID;
  String? phoneNumber;
  String? employeeCode;
  List<Student>? listStudent;
  Employee? employeeInfo;
  LoginModelResult(
      {this.parent,
      this.loginStatus,
      this.message,
      this.deviceID,
      this.fullName,
      this.phoneNumber,
      this.listStudent,
      this.employeeCode,
      this.employeeInfo});

  factory LoginModelResult.fromJson(Map<String, dynamic> json) {
    LoginModelResult loginModel = LoginModelResult();
    loginModel.loginStatus = json['LoginStatus'];
    loginModel.message = json['Message'];
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
        "LoginStatus": loginStatus,
        "Message": message,
        "FullName": fullName,
        "DeviceID": deviceID,
        "PhoneNumber": phoneNumber,
        "ListStudent": listStudent
      };
}
