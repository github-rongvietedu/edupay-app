class Reason {
  String? iD;
  String? companyCode;
  String? reasonName;
  bool? used;
  double? maxDayOff;

  Reason(
      {this.iD, this.companyCode, this.reasonName, this.used, this.maxDayOff});

  Reason.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    reasonName = json['ReasonName'];
    used = json['Used'];
    maxDayOff = json['MaxDayOff'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CompanyCode'] = this.companyCode;
    data['ReasonName'] = this.reasonName;
    data['Used'] = this.used;
    data['MaxDayOff'] = this.maxDayOff;
    return data;
  }
}
