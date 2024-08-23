class VehicleInfo {
  String? iD;
  String? companyCode;
  String? vehicleRegistrationNumber;
  String? vehicleName;
  String? description;
  DateTime? createdOn;
  String? createdBy;
  bool? used;

  VehicleInfo(
      {this.iD,
      this.companyCode,
      this.vehicleRegistrationNumber,
      this.vehicleName,
      this.description,
      this.createdOn,
      this.createdBy,
      this.used});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    vehicleRegistrationNumber = json['VehicleRegistrationNumber'];
    vehicleName = json['VehicleName'];
    description = json['Description'] ?? '';
    createdOn =
        json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null;
    ;
    createdBy = json['CreatedBy'] ?? '';
    used = json['Used'];
  }
}
