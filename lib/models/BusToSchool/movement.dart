import 'assistant_info.dart';
import 'driver_info.dart';
import 'movement_guest_detail.dart';
import 'route_info.dart';
import 'vehicle_info.dart';

class Movement {
  String? iD;
  String? companyCode;
  String? movementCode;
  String? route;
  String? driver;
  String? assistant;
  DateTime? movementDate;
  int? sortNumber;
  String? description;
  DateTime? createdOn;
  String? createdBy;
  bool? template;
  bool? cancel;
  int? status;
  bool? warnining;
  String? vehicle;
  int? captureType;
  String? parentID;
  String? statusName;
  String? movementDate1;
  RouteInfo? routeInfo;
  DriverInfo? driverInfo;
  AssistantInfo? assistantInfo;
  VehicleInfo? vehicleInfo;
  List<GTS_MovementGuestDetail>? gts_MovementGuestDetail;

  Movement(
      {this.iD,
      this.companyCode,
      this.movementCode,
      this.route,
      this.driver,
      this.assistant,
      this.movementDate,
      this.sortNumber,
      this.description,
      this.createdOn,
      this.createdBy,
      this.template,
      this.cancel,
      this.status,
      this.warnining,
      this.vehicle,
      this.captureType,
      this.parentID,
      this.statusName,
      this.movementDate1,
      this.routeInfo,
      this.driverInfo,
      this.assistantInfo,
      this.vehicleInfo,
      this.gts_MovementGuestDetail});

  Movement.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    movementCode = json['MovementCode'];
    route = json['Route'];
    driver = json['Driver'];
    assistant = json['Assistant'];
    movementDate = json['MovementDate'] != null
        ? DateTime.parse(json['MovementDate'])
        : null;
    ;
    sortNumber = json['SortNumber'];
    description = json['Description'];
    createdOn =
        json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null;
    ;
    createdBy = json['CreatedBy'];
    template = json['Template'];
    cancel = json['Cancel'];
    status = json['Status'];
    warnining = json['Warnining'];
    vehicle = json['Vehicle'];
    captureType = json['CaptureType'];
    parentID = json['ParentID'];
    statusName = json['StatusName'];
    movementDate1 = json['MovementDate1'];
    routeInfo = json['RouteInfo'] != null
        ? RouteInfo.fromJson(json['RouteInfo'])
        : null;
    driverInfo = json['DriverInfo'] != null
        ? DriverInfo.fromJson(json['DriverInfo'])
        : null;
    assistantInfo = json['AssistantInfo'] != null
        ? AssistantInfo.fromJson(json['AssistantInfo'])
        : null;
    vehicleInfo = json['VehicleInfo'] != null
        ? VehicleInfo.fromJson(json['VehicleInfo'])
        : null;
    gts_MovementGuestDetail = <GTS_MovementGuestDetail>[];
    if (json['GTS_MovementLocationGuestDetail'] != null) {
      json['GTS_MovementLocationGuestDetail'].forEach((v) {
        gts_MovementGuestDetail!.add(GTS_MovementGuestDetail.fromJson(v));
      });
    }
  }
}
