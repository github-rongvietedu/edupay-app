import 'package:equatable/equatable.dart';

enum ChangePasswordStatus { initial, submitting, success, failure }

class ChangePasswordState extends Equatable {
  final String userLogin;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final ChangePasswordStatus status;
  final String message;
  @override
  List<Object> get props => [
        userLogin,
        currentPassword,
        newPassword,
        confirmPassword,
        status,
        message
      ];

  const ChangePasswordState(
      {this.userLogin = '',
      this.currentPassword = '',
      this.newPassword = '',
      this.message = '',
      this.confirmPassword = '',
      this.status = ChangePasswordStatus.initial});

  ChangePasswordState copyWith(
      {String? userLogin,
      String? currentPassword,
      String? newPassword,
      String? confirmPassword,
      ChangePasswordStatus? status,
      String? message}) {
    return ChangePasswordState(
        userLogin: userLogin ?? this.userLogin,
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
