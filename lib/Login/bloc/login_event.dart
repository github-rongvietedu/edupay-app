import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  final String userName;

  const LoginUsernameChanged({required this.userName});
  @override
  List<Object> get props => [userName];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  final String userName;
  final String password;
  const LoginSubmitted({required this.userName, required this.password});
  @override
  List<Object> get props => [userName, password];
}
