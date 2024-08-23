class FaceAttendanceResult {
  int? status;
  String? message;
  int? total;
  List<Attendance>? data;

  FaceAttendanceResult({this.status, this.message, this.total, this.data});

  FaceAttendanceResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <Attendance>[];
      json['data'].forEach((v) {
        data!.add(Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  String? mappingCode;
  String? personName;
  DateTime? dateOfBirth;
  late String uRLCaptureImage;
  DateTime? captureAt;
  String? deviceName;

  Attendance(
      {this.mappingCode = "",
      this.personName = "",
      this.dateOfBirth,
      this.uRLCaptureImage = "",
      this.deviceName = "",
      this.captureAt});

  Attendance.fromJson(Map<String, dynamic> json) {
    mappingCode = json['MappingCode'] ?? "";
    personName = json['PersonName'] ?? "";
    dateOfBirth = DateTime.parse(json['DateOfBirth']);
    uRLCaptureImage = json['URLCaptureImage'] ?? "";
    deviceName = json['DeviceName'] ?? "";
    captureAt = DateTime.parse(json['CaptureAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MappingCode'] = mappingCode;
    data['PersonName'] = personName;
    data['DateOfBirth'] = dateOfBirth;
    data['URLCaptureImage'] = uRLCaptureImage;
    data['CaptureAt'] = captureAt;
    return data;
  }
}
