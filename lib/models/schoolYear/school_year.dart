class SchoolYear {
  String? iD;
  String? companyCode;
  int? year;
  bool? closed;
  String? name;

  SchoolYear({this.iD, this.companyCode, this.year, this.closed, this.name});

  SchoolYear.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? "";
    companyCode = json['CompanyCode'] ?? "";
    year = json['Year'] ?? 0;
    closed = json['Closed'] ?? false;
    name = json['SchoolYearName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> SchoolYear = new Map<String, dynamic>();
    SchoolYear['ID'] = this.iD;
    SchoolYear['CompanyCode'] = this.companyCode;
    SchoolYear['Year'] = this.year;
    SchoolYear['Closed'] = this.closed;
    SchoolYear['SchoolYearName'] = this.name;
    return SchoolYear;
  }
}
