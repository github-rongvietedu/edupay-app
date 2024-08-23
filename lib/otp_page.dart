import 'package:bts_app/Login/login.dart';
import 'package:bts_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final String screenType;
  const OtpPage({Key? key, required this.phoneNumber, required this.screenType})
      : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String text = '';
  //String _localPincode = "NA";
  // ResetPasswordResultModel resetPasswordResultModel =
  //     ResetPasswordResultModel();

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
    String email = widget.phoneNumber;

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
              color: kPrimaryColor.withAlpha(20),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
              size: 16,
            ),
          ),
          onPressed: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LoginScreen()));
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        // brightness: Brightness.light,
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
                                'Mã xác thực OTP (bao gồm 6 chữ số) đã được gửi đến Số điện thoại của bạn, vui lòng nhập mã OTP để xác nhận đăng ký.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                          onPressed: () async {
                            // loginStore.validateOtpAndLogin(context, text);
                            if (text.length == 6) {
                              // ResetPasswordResultModel result =
                              //     await NetworkService().verifyCode(
                              //         email: widget.email,
                              //         pincode: text,
                              //         verifyType: 'ChangePassword');

                              // if (result.status == 2) {
                              //   if (widget.screenType == 'ChangePassword') {
                              //     Navigator.pushAndRemoveUntil(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               ChangePasswordScreen(email: email)),
                              //       (Route<dynamic> route) => false,
                              //     ); // );
                              //     return;
                              //   }

                              // if (widget.screenType == 'ActiveSms') {
                              //   Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LoginPage()),
                              //     (Route<dynamic> route) => false,
                              //   );
                              //   return;
                              // }
                            }
                          },

                          // _showMyDialog(
                          //     "Mã xác thực không chính xác hoặc đã hết hạn! Vui lòng kiểm tra và thử lại");

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kPrimaryColor),
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
                    textColor: kPrimaryColor,
                    rightIcon: const Icon(
                      Icons.backspace,
                      color: kPrimaryColor,
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
