class FoodMenu {
  String? iD;
  String? companyCode;
  String? menuName;
  String? menuDescription;
  bool? used;
  DateTime? createdOn;
  String? createdBy;
  DateTime? fromDate;
  DateTime? toDate;
  List<FoodMenuDetail>? foodMenuDetail;

  FoodMenu(
      {this.iD,
      this.companyCode,
      this.menuName,
      this.menuDescription,
      this.used,
      this.createdOn,
      this.createdBy,
      this.fromDate,
      this.toDate,
      this.foodMenuDetail});

  FoodMenu.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? "";
    companyCode = json['CompanyCode'] ?? "";
    menuName = json['MenuName'] ?? "";
    menuDescription = json['MenuDescription'] ?? "";
    used = json['Used'] ?? false;
    createdOn =
        json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null;
    createdBy = json['CreatedBy'] ?? "";
    fromDate =
        json['FromDate'] != null ? DateTime.parse(json['FromDate']) : null;
    toDate = json['ToDate'] != null ? DateTime.parse(json['ToDate']) : null;
    if (json['FoodMenuDetail'] != null) {
      foodMenuDetail = <FoodMenuDetail>[];
      json['FoodMenuDetail'].forEach((v) {
        foodMenuDetail!.add(FoodMenuDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = this.iD ?? "";
    data['CompanyCode'] = this.companyCode ?? "";
    data['MenuName'] = this.menuName ?? "";
    data['MenuDescription'] = this.menuDescription ?? "";
    data['Used'] = this.used;
    data['CreatedOn'] = this.createdOn?.toIso8601String();
    data['CreatedBy'] = this.createdBy ?? "";
    data['FromDate'] = this.fromDate?.toIso8601String();
    data['ToDate'] = this.toDate?.toIso8601String();
    if (this.foodMenuDetail != null) {
      data['FoodMenuDetail'] =
          this.foodMenuDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodMenuDetail {
  String? iD;
  String? foodMenu;
  String? menuCategory;
  String? menuDescription;
  int? menuSession;
  String? mealCategory;
  String? morningTime;
  String? noontime;
  String? afterNoonTime;
  String? otherTime;
  DateTime? dayOfWeek;

  FoodMenuDetail(
      {this.iD,
      this.foodMenu,
      this.menuCategory,
      this.menuDescription,
      this.menuSession,
      this.mealCategory,
      this.morningTime,
      this.noontime,
      this.afterNoonTime,
      this.otherTime,
      this.dayOfWeek});

  FoodMenuDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? "";
    foodMenu = json['FoodMenu'] ?? "";
    menuCategory = json['MenuCategory'] ?? "";
    menuDescription = json['MenuDescription'] ?? "";
    menuSession = json['MenuSession'] ?? 0;
    mealCategory = json['MealCategory'] ?? "";
    morningTime = json['MorningTime'] ?? "";
    noontime = json['Noontime'] ?? "";
    afterNoonTime = json['AfterNoonTime'] ?? "";
    otherTime = json['OtherTime'] ?? "";
    dayOfWeek =
        json['DayOfWeek'] != null ? DateTime.parse(json['DayOfWeek']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = this.iD ?? "";
    data['FoodMenu'] = this.foodMenu ?? "";
    data['MenuCategory'] = this.menuCategory ?? "";
    data['MenuDescription'] = this.menuDescription ?? "";
    data['MenuSession'] = this.menuSession;
    data['MealCategory'] = this.mealCategory;
    data['MorningTime'] = this.morningTime;
    data['Noontime'] = this.noontime;
    data['AfterNoonTime'] = this.afterNoonTime;
    data['OtherTime'] = this.otherTime;
    data['DayOfWeek'] = this.dayOfWeek?.toIso8601String();
    return data;
  }
}
