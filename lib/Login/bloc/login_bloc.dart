import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../config/networkservice.dart';
import '../../models/loginModel/loginModel.dart';
import '../../models/loginModel/loginmodelresult.dart';
import '../../models/profile.dart';
import '../../models/secure_store.dart';
import '../../utils.dart';
import 'form_status.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final secureStore = SecureStore();
  final BuildContext context;
  LoginBloc(this.context) : super(const LoginState()) {
    on<LoginUsernameChanged>(_onLoginUsernameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }
  void _onLoginUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        userName: event.userName,
        password: event.password,
        formStatus: const FormSubmitting()));

    LoginModel loginModel = LoginModel();
    loginModel.userValue = state.userName;
    loginModel.passValue = state.password;
    loginModel.deviceID = '';
    loginModel.registrationToken = await FirebaseMessaging.instance.getToken();
    loginModel.companyCode = Profile.companyCode;
    print(loginModel.registrationToken);
    LoginModelResult loginModelResult = LoginModelResult();
    loginModelResult.loginStatus = false;
    loginModelResult.message = "Đăng nhập thất bại !!";
    loginModelResult.phoneNumber = "";
    loginModelResult.deviceID = "";
    loginModelResult.fullName = "";
    loginModelResult.listStudent = [];

    if (loginModel.userValue == '') {
      emit(state.copyWith(
          formStatus: const FormSubmitFailed(),
          message: loginModelResult.message));
    } else {
      try {
        loginModelResult = await loadingDialog.showLoadingPopup(
            context, NetworkService().login(loginModel),
            loadingText: "test");
        if (loginModelResult.loginStatus == true) {
          secureStore.writeSecureData('userlogin', loginModel.userValue ?? "");
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          Profile.parentID = loginModelResult.parent as String;
          String passwordEncoded =
              stringToBase64.encode(loginModel.passValue ?? "");
          secureStore.writeSecureData('password', passwordEncoded);

          DateTime now = DateTime.now();
          String valueDate = DateFormat('yyyy-MM-dd').format(now);
          secureStore.writeSecureData('lastLogin', valueDate);
          // prefs.setString('LastLoginDate', valueDate);
          // lastDate = DateTime.parse(valueDate);
          // bool isNoImage = false;
          loginModelResult.message = "Đăng nhập thành công !!!";
          // if (loginModelResult.listStudent!.isNotEmpty) {
          //   loginModelResult.listStudent?.forEach((element) {
          //     if (element.faceImageURL == "" || element.faceImageURL == null) {
          //       isNoImage = true;
          //     } else {
          //       isNoImage = false;
          //       // throw 'Stop this immediately';
          //     }
          //   });
          // }
          // if (isNoImage == true) {
          //   emit(state.copyWith(
          //       formStatus: const FormSubmitFailed(),
          //       message:
          //           "Đăng nhập thất bại !!! Học sinh chưa có ảnh liên kết. Vui lòng liên hệ quản trị viên để được hỗ trợ sớm nhất."));
          // } else {

          // }
          if (loginModelResult.employeeCode != "") {
            emit(state.copyWith(
                formStatus: const FormSubmitSuccessTeacher(),
                message: loginModelResult.message));
          } else {
            emit(state.copyWith(
                formStatus: const FormSubmitSuccess(),
                message: loginModelResult.message));
          }
        } else {
          emit(state.copyWith(
              formStatus: const FormSubmitFailed(),
              message: loginModelResult.message));
        }
      } catch (ex) {
        emit(state.copyWith(formStatus: const FormSubmitFailed()));
      }
    }
  }
}
