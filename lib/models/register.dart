class RegisterResult {
  int? status;
  String? message;
  String? phoneNumber;

  RegisterResult({this.status, this.message});

  RegisterResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    phoneNumber = json['PhoneNumber'] ?? "";
  }
}
