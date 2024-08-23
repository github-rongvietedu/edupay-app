import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../ChangePassword/change_password.dart';
import '../../config/DataService.dart';
import '../../constants.dart';
import '../../utils.dart';
import '../resetpasswordmodel.dart';
import '../secure_store.dart';
import 'change_password.dart';

class OtpPage extends StatefulWidget {
  final String? userLogin;
  final String? screenType;
  const OtpPage({Key? key, this.userLogin, this.screenType}) : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String text = '';
  //String _localPincode = "NA";
  ResetPasswordResultModel resetPasswordResultModel =
      ResetPasswordResultModel();
  bool isTimeOut = false;
  Duration myDuration = Duration(minutes: 5);
  late Timer _timer;
  late String userLogin;
  late String screenType;
  int duration = 300;
  SecureStore secureStore = SecureStore();
  Future<void> _showMyDialog(String text) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("${text}"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onKeyboardTap(String value) {
    if (text.length < 6) {
      text = text + value;
      setState(() {});
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    int reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;

      if (seconds < 0) {
        _timer.cancel();
        isTimeOut = true;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer() {
    setState(() => _timer.cancel());
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    userLogin = widget.userLogin!;
    screenType = widget.screenType!;
    startTimer();
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    String userLogin = widget.userLogin!;

    // resetPasswordResultModel = ModalRoute.of(context).settings.arguments;
    // resetPasswordResultModel.pincode = "222222";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: primaryColor.withAlpha(20),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
              size: 16,
            ),
          ),
          onPressed: () async {
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => const LoginPage()));
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white, systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Text(
                                'Vui lòng nhập 6 chữ số xác thực đã được gửi đến số điện thoại của bạn.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500))),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(0),
                              otpNumberWidget(1),
                              otpNumberWidget(2),
                              otpNumberWidget(3),
                              otpNumberWidget(4),
                              otpNumberWidget(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: isTimeOut
                          ? () async {
                              await NetworkService()
                                  .getVerifyCode(
                                phoneNumber: userLogin,
                              )
                                  .then((value) {
                                if (value.status == 2) {
                                  setState(() {
                                    myDuration = Duration(seconds: duration);
                                    isTimeOut = false;
                                    startTimer();
                                  });
                                } else {
                                  _showMyDialog(
                                      "Quá số lần lấy mã xác thực, vui lòng liên hệ quản trị viên để được hỗ trợ !!!");
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const LoginPage()),

                                  //   (Route<dynamic> route) => false,
                                  // );
                                }
                              });
                            }
                          : null,
                      child: isTimeOut
                          ? Text("Gửi lại mã")
                          : Text("Gửi lại mã ($minutes:$seconds)")),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          onPressed: () async {
                            String? firebaseToken =
                                await FirebaseMessaging.instance.getToken();
                            // loginStore.validateOtpAndLogin(context, text);
                            if (text.length == 6) {
                              ResetPasswordResultModel result =
                                  await loadingDialog.showLoadingPopup(
                                      context,
                                      NetworkService().verifyCode(
                                          email: widget.userLogin,
                                          pincode: text,
                                          verifyType: 'ChangePassword'));

                              if (result.status == 2) {
                                if (widget.screenType == 'ChangePassword') {
                                  _timer.cancel();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChangePassword(
                                        userLogin: userLogin,
                                        screenType: widget.screenType ?? "",
                                      ),
                                    ),
                                    (Route<dynamic> route) => false,
                                  ); // );
                                  return;
                                }

                                if (widget.screenType == 'ActiveAccount') {
                                  _timer.cancel();
                                  Codec<String, String> stringToBase64 =
                                      utf8.fuse(base64);
                                  String valueDate = DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now());

                                  secureStore.writeSecureData(
                                      'userLogin', userLogin);

                                  secureStore.writeSecureData(
                                      'lastLogin', valueDate);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (Route<dynamic> route) => false);
                                  return;
                                }
                              }
                            }

                            _showMyDialog(
                                "Mã xác thực không chính xác hoặc đã hết hạn! Vui lòng kiểm tra và thử lại");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                          child: const Text("Xác thực",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16))),
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: primaryColor,
                    rightIcon: const Icon(
                      Icons.backspace,
                      color: primaryColor,
                    ),
                    rightButtonFn: () {
                      setState(() {
                        text = text.substring(0, text.length - 1);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
