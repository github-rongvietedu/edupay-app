import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, submitting, success, failure }

class RegisterState extends Equatable {
  final String phoneNumber;
  final String partnerName;
  final String companyCode;
  final String address;
  final String password;
  final RegisterStatus status;
  final String message;
  @override
  List<Object> get props => [
        phoneNumber,
        address,
        password,
        partnerName,
        companyCode,
        status,
        message
      ];

  const RegisterState(
      {this.phoneNumber = '',
      this.partnerName = '',
      this.companyCode = '',
      this.message = '',
      this.address = '',
      this.password = '',
      this.status = RegisterStatus.initial});

  RegisterState copyWith(
      {String? phoneNumber,
      String? partnerName,
      String? companyCode,
      String? password,
      String? address,
      RegisterStatus? status,
      String? message}) {
    return RegisterState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        partnerName: partnerName ?? this.partnerName,
        companyCode: companyCode ?? this.companyCode,
        address: address ?? this.address,
        password: password ?? this.password,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
