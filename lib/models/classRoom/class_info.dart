import '../TimeTable/time_table.dart';

class ClassInfo {
  late String iD;
  late String companyCode;
  late String schoolYear;
  late String gradeCode;
  late String roomName;
  late String room;
  late String name;
  late String mainTeacherName;
  late String teacherID;
  late List<TimeTable>? listTimeTable;
  ClassInfo(
      {this.iD = "",
      this.companyCode = "",
      this.schoolYear = "",
      this.gradeCode = "",
      this.roomName = "",
      this.room = "",
      this.name = "",
      this.teacherID = "",
      this.mainTeacherName = ""});

  ClassInfo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? "";
    companyCode = json['CompanyCode'] ?? "";
    schoolYear = json['SchoolYear'] ?? "";
    gradeCode = json['GradeCode'] ?? "";
    roomName = json['RoomName'] ?? "";
    room = json['Room'] ?? "";
    name = json['ClassName'] ?? "";
    mainTeacherName = json['MainTeacherName'] ?? "";
    teacherID = json['TeacherID'] ?? "";
    if (json['GTS_ClassRoomScheduleDetail'] != null) {
      listTimeTable = <TimeTable>[];
      json['GTS_ClassRoomScheduleDetail'].forEach((v) {
        listTimeTable!.add(TimeTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CompanyCode'] = this.companyCode;
    data['SchoolYear'] = this.schoolYear;
    data['GradeCode'] = this.gradeCode;
    data['RoomName'] = this.roomName;
    data['Room'] = this.room;
    data['ClassName'] = this.name;
    data['MainTeacherName'] = this.mainTeacherName;
    return data;
  }
}
