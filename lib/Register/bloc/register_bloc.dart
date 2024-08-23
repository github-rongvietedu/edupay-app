import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/DataService.dart';
import '../../models/register.dart';
import '../../models/secure_store.dart';
import '../../utils.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final secureStore = SecureStore();
  final BuildContext context;
  RegisterBloc(this.context) : super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(
        phoneNumber: event.phoneNumber,
        partnerName: event.partnerName,
        companyCode: event.companyCode,
        password: event.password,
        address: event.address,
        status: RegisterStatus.submitting));

    RegisterResult registerResult = RegisterResult();
    // RegisterModelResult.message = "Đăng nhập thất bại !!";
    if (state.partnerName == "") {
      emit(state.copyWith(
          status: RegisterStatus.failure,
          message: "Họ tên không được để trống !!!"));
      return;
    }

    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String passwordEncoded = stringToBase64.encode(state.password);
      registerResult = await loadingDialog.showLoadingPopup(
          context,
          NetworkService().register(state.phoneNumber, state.companyCode,
              state.partnerName, state.address, passwordEncoded));

      if (registerResult.status == 2) {
        // secureStore.writeSecureData('', (state.phoneNumber));

        emit(state.copyWith(
            status: RegisterStatus.success, message: registerResult.message));
      } else {
        emit(state.copyWith(
            status: RegisterStatus.failure, message: registerResult.message));
      }
    } catch (ex) {
      emit(state.copyWith(
          status: RegisterStatus.failure, message: "Đổi mật khẩu thất bại !!"));
    }
  }
}
