import 'foodmenu_detail.dart';

class FoodMenu {
  final String id;
  final String menuName;
  final String menuDescription;
  final String companyCode;
  final bool used;
  final String createdBy;
  final DateTime? createdOn;
  List<MenuFoodDetail>? menuFoodDetail;
  FoodMenu(
      {this.id = "",
      this.menuName = "",
      this.menuDescription = "",
      this.companyCode = "",
      this.used = false,
      this.createdBy = "",
      this.createdOn,
      this.menuFoodDetail});

  factory FoodMenu.fromJson(Map<String, dynamic> json) {
    FoodMenu foodMenu = FoodMenu(
      id: json['ID'] ?? "",
      menuName: json['MenuName'] ?? "",
      menuDescription: json['MenuDescription'] ?? "",
      companyCode: json['CompanyCode'] ?? "",
      used: json['Used'] ?? false,
      createdBy: json['CreatedBy'] ?? "",
      // createdOn:json['CreatedOn']!=null? DateTime.parse(json['CreatedOn']):DateTime.now(),
    );
    foodMenu.menuFoodDetail = [];
    if (json['GTS_MenuFoodDetail'] != null) {
      for (var foodDetail in json['GTS_MenuFoodDetail']) {
        foodMenu.menuFoodDetail?.add(MenuFoodDetail.fromJson(foodDetail));
      }
    }

    return foodMenu;
  }
}
