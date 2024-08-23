class AssistantInfo {
  String? iD;
  String? companyCode;
  String? employeeCode;
  String? mappingCode;
  String? fullName;
  String? branchCode;
  int? employeeType;
  String? phoneNumber;
  String? email;
  bool? used;

  AssistantInfo({
    this.iD,
    this.companyCode,
    this.employeeCode,
    this.mappingCode,
    this.fullName,
    this.branchCode,
    this.employeeType,
    this.phoneNumber,
    this.email,
    this.used,
  });

  AssistantInfo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    mappingCode = json['MappingCode'];
    fullName = json['FullName'] ?? '';
    branchCode = json['BranchCode'];
    employeeType = json['EmployeeType'];
    phoneNumber = json['PhoneNumber'];
    email = json['Email'] ?? '';
    used = json['Used'];
  }
}
