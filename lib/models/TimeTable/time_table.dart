class TimeTable {
  String? iD;
  String? classRoom;
  int? lessonType;
  int? scheduleDay;
  String? subject;
  String? teacherCode;
  String? lessonNumber;
  int? scheduleDayNumber;
  String? lessonName;
  String? lessionTimeDescription;
  String? scheduleDayName;
  String? lessonTypeName;
  String? subjectName;
  String? teacherName;

  TimeTable(
      {this.iD,
      this.classRoom,
      this.lessonType,
      this.scheduleDay,
      this.subject,
      this.teacherCode,
      this.lessonNumber,
      this.scheduleDayNumber,
      this.lessonName,
      this.lessionTimeDescription,
      this.scheduleDayName,
      this.lessonTypeName,
      this.subjectName,
      this.teacherName});

  TimeTable.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    classRoom = json['ClassRoom'];
    lessonType = json['LessonType'];
    scheduleDay = json['ScheduleDay'];
    subject = json['Subject'];
    teacherCode = json['TeacherCode'];
    lessonNumber = json['LessonNumber'];
    scheduleDayNumber = json['ScheduleDayNumber'];
    lessonName = json['LessonName'];
    lessionTimeDescription = json['LessionTimeDescription'];
    scheduleDayName = json['ScheduleDayName'];
    lessonTypeName = json['LessonTypeName'];
    subjectName = json['SubjectName'];
    teacherName = json['TeacherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ClassRoom'] = this.classRoom;
    data['LessonType'] = this.lessonType;
    data['ScheduleDay'] = this.scheduleDay;
    data['Subject'] = this.subject;
    data['TeacherCode'] = this.teacherCode;
    data['LessonNumber'] = this.lessonNumber;
    data['ScheduleDayNumber'] = this.scheduleDayNumber;
    data['LessonName'] = this.lessonName;
    data['LessionTimeDescription'] = this.lessionTimeDescription;
    data['ScheduleDayName'] = this.scheduleDayName;
    data['LessonTypeName'] = this.lessonTypeName;
    data['SubjectName'] = this.subjectName;
    data['TeacherName'] = this.teacherName;
    return data;
  }
}
