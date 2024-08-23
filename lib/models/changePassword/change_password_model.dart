class ChangePasswordModel {
  late String userLogin;
  late String currentPassword;
  late String newPassword;
  late String confirmPassword;

  ChangePasswordModel({
    this.userLogin = "",
    this.currentPassword = "",
    this.newPassword = "",
    this.confirmPassword = "",
  });
  Map<String, dynamic> toJson() => {
        "UserLogin": userLogin,
        "CurrentPassword": currentPassword,
        "NewPassword": newPassword,
        "ConfirmPassword": confirmPassword,
      };
}
