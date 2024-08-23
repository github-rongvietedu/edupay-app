class Result {
  int? status;
  String? message;

  Result({
    this.status,
    this.message,
  });

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
