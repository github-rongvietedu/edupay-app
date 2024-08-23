class GTS_MovementGuestDetail {
  String? iD;
  String? movement;
  String? route;
  String? student;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  DateTime? createdOn;
  String? createdBy;
  bool? off;
  String? location;
  bool? absent;
  String? incidentReport;
  String? studentName;
  String? faceImageURL;

  GTS_MovementGuestDetail(
      {this.iD,
      this.movement,
      this.route,
      this.student,
      this.checkInDate,
      this.checkOutDate,
      this.createdOn,
      this.createdBy,
      this.off,
      this.location,
      this.absent,
      this.incidentReport,
      this.studentName,
      this.faceImageURL});

  GTS_MovementGuestDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    movement = json['Movement'];
    route = json['Route'] ?? '';
    student = json['Student'];
    checkInDate = json['CheckInDate'] != null
        ? DateTime.parse(json['CheckInDate'])
        : null;
    checkOutDate = json['CheckOutDate'] != null
        ? DateTime.parse(json['CheckOutDate'])
        : null;
    createdOn =
        json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null;
    createdBy = json['CreatedBy'];
    off = json['Off'];
    location = json['Location'];
    absent = json['Absent'] ?? false;
    incidentReport = json['IncidentReport'] ?? '';
    studentName = json['StudentName'];
    faceImageURL = json['FaceImageURL'];
  }
}
