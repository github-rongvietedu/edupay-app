import 'package:equatable/equatable.dart';

import 'form_status.dart';

class LoginState extends Equatable {
  final String userName;
  final String password;
  final FormStatus formStatus;
  final String message;
  @override
  List<Object> get props => [userName, password, formStatus, message];

  const LoginState(
      {this.userName = '',
      this.password = '',
      this.message = '',
      this.formStatus = const InitFormStatus()});

  LoginState copyWith(
      {String? userName,
      String? password,
      FormStatus? formStatus,
      String? message}) {
    return LoginState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        message: message ?? this.message);
  }
}
