import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String userLogin;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  const ChangePasswordSubmitted(
      {required this.userLogin,
      required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});
  @override
  List<Object> get props =>
      [userLogin, currentPassword, newPassword, confirmPassword];
}
