import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/DataService.dart';
import '../../models/changePassword/change_password_model.dart';
import '../../models/changePassword/change_password_result.dart';
import '../../models/secure_store.dart';
import '../../utils.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final secureStore = SecureStore();
  final BuildContext context;
  ChangePasswordBloc(this.context) : super(const ChangePasswordState()) {
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  Future<void> _onChangePasswordSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
        userLogin: event.userLogin,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
        status: ChangePasswordStatus.submitting));

    ChangePasswordModel changePasswordModel = ChangePasswordModel();
    changePasswordModel.userLogin = state.userLogin;
    changePasswordModel.currentPassword = state.currentPassword;
    changePasswordModel.newPassword = state.newPassword;
    changePasswordModel.confirmPassword = state.confirmPassword;

    ChangePasswordResult changePasswordModelResult = ChangePasswordResult();
    // changePasswordModelResult.message = "Đăng nhập thất bại !!";
    if (state.newPassword == "" || state.newPassword.length < 6) {
      emit(state.copyWith(
          status: ChangePasswordStatus.failure,
          message:
              "Mật khẩu mới không được để trống hoặc nhỏ hơn 6 ký tự !!!"));
      return;
    }
    if (state.confirmPassword == "") {
      emit(state.copyWith(
          status: ChangePasswordStatus.failure,
          message: "Xác nhận mật khẩu không được để trống !!!"));
      return;
    }
    if (state.newPassword.compareTo(state.confirmPassword) != 0) {
    } else {
      try {
        changePasswordModelResult = await loadingDialog.showLoadingPopup(
            context, DataService().changePassword(changePasswordModel));

        if (changePasswordModelResult.status == 2) {
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          String passwordEncoded =
              stringToBase64.encode(changePasswordModel.newPassword);
          secureStore.writeSecureData('password', passwordEncoded);

          emit(state.copyWith(
              status: ChangePasswordStatus.success,
              message: changePasswordModelResult.message));
        } else {
          emit(state.copyWith(
              status: ChangePasswordStatus.failure,
              message: changePasswordModelResult.message));
        }
      } catch (ex) {
        emit(state.copyWith(
            status: ChangePasswordStatus.failure,
            message: "Đổi mật khẩu thất bại !!"));
      }
    }
  }
}
