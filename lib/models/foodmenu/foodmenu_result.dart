import 'foodmenu.dart';

class FoodMenuResult {
  int? status;
  String? message;
  int? total;
  List<FoodMenu>? data;

  FoodMenuResult({this.status, this.message, this.total, this.data});

  FoodMenuResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <FoodMenu>[];
      json['data'].forEach((v) {
        data!.add(FoodMenu.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   data['total'] = this.total;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
