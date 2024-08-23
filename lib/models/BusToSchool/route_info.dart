class RouteInfo {
  String? iD;
  String? companyCode;
  String? routeCode;
  String? routeName;
  String? arrivalLocation;
  String? destinationLocation;
  String? description;
  DateTime? createdOn;
  String? createdBy;
  bool? used;

  RouteInfo(
      {this.iD,
      this.companyCode,
      this.routeCode,
      this.routeName,
      this.arrivalLocation,
      this.destinationLocation,
      this.description,
      this.createdOn,
      this.createdBy,
      this.used});

  RouteInfo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    routeCode = json['RouteCode'];
    routeName = json['RouteName'];
    arrivalLocation = json['ArrivalLocation'];
    destinationLocation = json['DestinationLocation'];
    description = json['Description'] ?? '';
    createdOn = json['CreatedOn'];
    createdBy = json['CreatedBy'] ?? '';
    used = json['Used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CompanyCode'] = this.companyCode;
    data['RouteCode'] = this.routeCode;
    data['RouteName'] = this.routeName;
    data['ArrivalLocation'] = this.arrivalLocation;
    data['DestinationLocation'] = this.destinationLocation;
    data['Description'] = this.description;
    data['CreatedOn'] = this.createdOn;
    data['CreatedBy'] = this.createdBy;
    data['Used'] = this.used;
    return data;
  }
}
