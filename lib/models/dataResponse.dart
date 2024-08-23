// To parse this JSON data, do
//
//     final dataResponse = dataResponseFromJson(jsonString);

import 'dart:convert';

class DataResponse {
  DataResponse({
    this.status = 4,
    this.message = "",
    this.hasMorePages = false,
    this.total = 0,
    this.realTotal = 0,
    this.data,
  });

  int status;
  String message;
  bool hasMorePages;
  int total;
  int realTotal;
  dynamic data;

  factory DataResponse.fromRawJson(String str) =>
      DataResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
        status: json["status"] ?? 4,
        message: json["message"] ?? "",
        hasMorePages: json["hasMorePages"] ?? false,
        total: json["total"] ?? 0,
        realTotal: json["realTotal"] ?? 0,
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "hasMorePages": hasMorePages,
        "total": total,
        "realTotal": realTotal,
        "data": data,
      };
}
