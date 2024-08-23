class CompanyInfo {
  String? companyName;
  String? prefix;
  bool? used;
  String? webHostDomain;

  bool? hidenMainTeacherInClassRoom;
  int? pincodeLifetimeInSecond;

  CompanyInfo(
      {this.companyName,
      this.prefix,
      this.used,
      this.webHostDomain,
      this.hidenMainTeacherInClassRoom,
      this.pincodeLifetimeInSecond});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    companyName = json['CompanyName'];
    prefix = json['Prefix'];
    used = json['Used'];
    webHostDomain = json['WebHostDomain'];
    hidenMainTeacherInClassRoom = json['HidenMainTeacherInClassRoom'];
    pincodeLifetimeInSecond = json['PincodeLifetimeInSecond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyName'] = this.companyName;
    data['Prefix'] = this.prefix;
    data['Used'] = this.used;
    data['WebHostDomain'] = this.webHostDomain;
    data['HidenMainTeacherInClassRoom'] =
        this.hidenMainTeacherInClassRoom ?? false;
    data['PincodeLifetimeInSecond'] = this.pincodeLifetimeInSecond ?? 300;
    return data;
  }
}
