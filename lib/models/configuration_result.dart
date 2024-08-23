import 'configuration.dart';

class ConfigurationResult {
  int? status;
  String? message;
  Configuration? data;

  ConfigurationResult({this.status, this.message, this.data});

  ConfigurationResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Configuration.fromJson(json['data']) : null;
  }
}
