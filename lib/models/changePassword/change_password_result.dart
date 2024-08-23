class ChangePasswordResult {
  final int status;
  final String errorCode;
  final String pincode;
  final String message;

  ChangePasswordResult({
    this.status = -1,
    this.errorCode = "",
    this.pincode = "",
    this.message = "",
  });
  factory ChangePasswordResult.fromJson(Map<String, dynamic> json) {
    ChangePasswordResult changePasswordResult = ChangePasswordResult(
      status: json['status'],
      errorCode: json['errorCode'] ?? "",
      pincode: json['pinCode'] ?? "",
      message: json['message'] ?? "",
    );

    return changePasswordResult;
  }
}
