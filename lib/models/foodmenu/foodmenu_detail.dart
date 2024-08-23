class MenuFoodDetail {
  String? iD;
  String? foodMenu;
  String? menuCategory;
  String? menuDescription;
  int? menuSession;

  MenuFoodDetail(
      {this.iD,
      this.foodMenu,
      this.menuCategory,
      this.menuDescription,
      this.menuSession});

  MenuFoodDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? "";
    foodMenu = json['FoodMenu'] ?? "";
    menuCategory = json['MenuCategory'] ?? "";
    menuDescription = json['MenuDescription'] ?? "";
    menuSession = json['MenuSession'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['FoodMenu'] = this.foodMenu;
    data['MenuCategory'] = this.menuCategory;
    data['MenuDescription'] = this.menuDescription;
    data['MenuSession'] = this.menuSession;
    return data;
  }
}
