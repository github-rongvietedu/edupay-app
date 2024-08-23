import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String phoneNumber;
  final String companyCode;
  final String partnerName;
  final String address;
  final String password;

  const RegisterSubmitted(
      {required this.phoneNumber,
      required this.companyCode,
      required this.partnerName,
      required this.password,
      required this.address});
  @override
  List<Object> get props =>
      [phoneNumber, companyCode, partnerName, password, address];
}
