class ResetPasswordResultModel {
  final int? status;
  final String? errorCode;
  final String? pincode;
  final String? message;

  ResetPasswordResultModel(
      {this.status, this.errorCode, this.pincode, this.message});

  factory ResetPasswordResultModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResultModel(
      status: json['status'],
      errorCode: json['ErrorCode'] ?? "",
      pincode: json['Pincode'] ?? "",
      message: json['message'],
    );
  }
}
