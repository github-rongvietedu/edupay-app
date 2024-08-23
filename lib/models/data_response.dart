// To parse this JSON data, do
//
//     final dataResponse = dataResponseFromJson(jsonString);

import 'dart:convert';

class DataResponse {
  DataResponse({
    this.status,
    this.message,
    this.hasMorePages,
    this.total,
    this.realTotal,
    this.data,
  });

  int? status;
  String? message;
  bool? hasMorePages;
  int? total;
  int? realTotal;
  dynamic data;

  factory DataResponse.fromRawJson(String str) =>
      DataResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
        status: json["Status"],
        message: json["Message"],
        hasMorePages: json["hasMorePages"],
        total: json["total"],
        realTotal: json["realTotal"],
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
