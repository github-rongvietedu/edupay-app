class LoginModel {
  String? userValue;
  String? passValue;
  String? registrationToken;
  String? deviceID;
  String? companyCode;
  LoginModel(
      {this.userValue,
      this.passValue,
      this.deviceID,
      this.registrationToken,
      this.companyCode});
  Map<String, dynamic> toJson() => {
        "UserValue": userValue,
        "PassValue": passValue,
        "RegistrationToken": registrationToken,
        "DeviceID": deviceID,
        "CompanyCode": companyCode
      };
}
