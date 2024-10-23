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
  String? studentCode;
  String? studentName;
  DateTime? dateOfBirth;
  late String faceImageURL;
  DateTime? captureTime;
  String? deviceName;

  Attendance(
      {this.studentCode = "",
      this.studentName = "",
      this.dateOfBirth,
      this.faceImageURL = "",
      this.deviceName = "",
      this.captureTime});

  Attendance.fromJson(Map<String, dynamic> json) {
    studentCode = json['StudentCode'] ?? "";
    studentName = json['StudentName'] ?? "";
    dateOfBirth = DateTime.parse(json['DateOfBirth']);
    faceImageURL = json['CaptureImageURL'] ?? "";
    deviceName = json['DeviceName'] ?? "";
    captureTime = DateTime.parse(json['CaptureTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StudentCode'] = studentCode;
    data['StudentName'] = studentName;
    data['DateOfBirth'] = dateOfBirth;
    data['CaptureImageURL'] = faceImageURL;
    data['CaptureTime'] = captureTime;
    return data;
  }
}
