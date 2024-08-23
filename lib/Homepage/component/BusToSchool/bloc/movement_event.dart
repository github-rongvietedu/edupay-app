import 'package:equatable/equatable.dart';

abstract class MovementEvent extends Equatable {
  const MovementEvent();
  @override
  List<Object> get props => [];
}

class LoadMovement extends MovementEvent {
  final String phoneNumber;
  final String companyCode;
  final DateTime date;
  // final DateTime date;

  const LoadMovement(
    this.phoneNumber,
    this.companyCode,
    this.date,
  );
  @override
  List<Object> get props => [phoneNumber, companyCode, date];
}
