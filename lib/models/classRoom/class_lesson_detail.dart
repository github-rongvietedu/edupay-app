class ClassLessonDetail {
  String? iD;
  String? companyCode;
  String? lessonCode;
  String? lessonName;
  int? sortNumber;
  String? content;
  bool? used;
  DateTime? createdOn;
  String? createdBy;
  String? grade;
  DateTime? startDate;
  DateTime? endDate;

  ClassLessonDetail(
      {this.iD,
      this.companyCode,
      this.lessonCode,
      this.lessonName,
      this.sortNumber,
      this.content,
      this.used,
      this.createdOn,
      this.createdBy,
      this.grade,
      this.startDate,
      this.endDate});

  ClassLessonDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? '';
    companyCode = json['CompanyCode'] ?? '';
    lessonCode = json['LessonCode'] ?? '';
    lessonName = json['LessonName'] ?? '';
    sortNumber = json['SortNumber'] ?? 0;
    content = json['Content'] ?? '';
    used = json['Used'] ?? false;
    createdOn =
        json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null;
    createdBy = json['CreatedBy'] ?? '';
    grade = json['Grade'] ?? '';
    startDate =
        json['StartDate'] != null ? DateTime.parse(json['StartDate']) : null;
    endDate = json['EndDate'] != null ? DateTime.parse(json['EndDate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD ?? '';
    data['CompanyCode'] = this.companyCode ?? '';
    data['LessonCode'] = this.lessonCode ?? '';
    data['LessonName'] = this.lessonName ?? '';
    data['SortNumber'] = this.sortNumber ?? 0;
    data['Content'] = this.content ?? '';
    data['Used'] = this.used ?? false;
    data['CreatedOn'] =
        this.createdOn != null ? this.createdOn!.toIso8601String() : null;
    data['CreatedBy'] = this.createdBy ?? '';
    data['Grade'] = this.grade ?? '';
    data['StartDate'] =
        this.startDate != null ? this.startDate!.toIso8601String() : null;
    data['EndDate'] =
        this.endDate != null ? this.endDate!.toIso8601String() : null;
    return data;
  }
}
