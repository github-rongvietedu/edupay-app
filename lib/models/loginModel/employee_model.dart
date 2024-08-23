class Employee {
  String? iD;
  String? companyCode;
  String? employeeCode;
  String? mappingCode;
  String? fullName;
  String? branchCode;
  int? employeeType;
  String? phoneNumber;
  String? email;

  Employee(
      {this.iD,
      this.companyCode,
      this.employeeCode,
      this.mappingCode,
      this.fullName,
      this.branchCode,
      this.employeeType,
      this.phoneNumber,
      this.email});

  Employee.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'] ?? "";
    mappingCode = json['MappingCode'] ?? "";
    fullName = json['FullName'];
    branchCode = json['BranchCode'] ?? "";
    employeeType = json['EmployeeType'];
    phoneNumber = json['PhoneNumber'] ?? "";
    email = json['Email'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['MappingCode'] = this.mappingCode;
    data['FullName'] = this.fullName;
    data['BranchCode'] = this.branchCode;
    data['EmployeeType'] = this.employeeType;
    data['PhoneNumber'] = this.phoneNumber;
    data['Email'] = this.email;
    return data;
  }
}
