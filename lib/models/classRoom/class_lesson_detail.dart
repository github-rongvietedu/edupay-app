class ClassLessonDetail {
  String id;
  String classRoom;
  DateTime? fromDate;
  DateTime? toDate;
  String lesson;
  String lessonContent;
  String lessonName;
  ClassLessonDetail(
      {this.id = "",
      this.classRoom = "",
      this.fromDate,
      this.toDate,
      this.lesson = "",
      this.lessonContent = "",
      this.lessonName = ""});

  factory ClassLessonDetail.fromJson(Map<String, dynamic> json) {
    ClassLessonDetail lesson = ClassLessonDetail(
      id: json['ID'] ?? "",
      classRoom: json['ClassRoom'] ?? "",
      fromDate: DateTime.parse(json['FromDate']),
      toDate: DateTime.parse(json['ToDate']),
      lesson: json['Lesson'] ?? "",
      lessonContent: json['LessonContent'] ?? "",
      lessonName: json['LessonName'] ?? "",
    );

    return lesson;
  }
}
