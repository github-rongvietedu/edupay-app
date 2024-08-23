import 'package:equatable/equatable.dart';

import '../../../../models/BusToSchool/movement.dart';
import '../../../../models/student.dart';

enum MovementStatus { initial, changed, success, failure }

class MovementState extends Equatable {
  final MovementStatus status;
  final List<Movement> listMovement;
  final String message;
  @override
  List<Object> get props => [
        status,
        message,
      ];

  const MovementState(
      {required this.listMovement,
      this.message = '',
      this.status = MovementStatus.initial});

  MovementState copyWith(
      {Student? student,
      DateTime? date,
      MovementStatus? status,
      List<Movement>? listMovement,
      String? message}) {
    return MovementState(
        status: status ?? this.status,
        listMovement: listMovement ?? this.listMovement,
        message: message ?? this.message);
  }
}
