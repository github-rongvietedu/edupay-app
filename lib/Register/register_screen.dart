import 'dart:io';

import 'package:edupay/otp_page.dart';
import 'package:edupay/widget/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as gradient;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../constants.dart';
import '../models/configuration.dart';
import '../models/profile.dart';
import '../widget/rounded_button.dart';
import '../widget/rounded_input_field.dart';
import '../widget/webViewPage.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation sizeAnimation;
  late Size size;
  final _partnerNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late bool isAgree = false;
  late Configuration configuration = Configuration();
  late String version = "";
  late String code = "";
  bool warningVersion = false;
  String appVersion = "";
  String platform = 'Android';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    sizeAnimation = Tween<double>(begin: 100, end: 270).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('HTS Minh Đức'),
          content: Text('Bạn có chắc là bạn muốn thoát ứng dụng'),
          actions: <Widget>[
            TextButton(
              child: Text("Quay lại"),
              onPressed: () async {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Thoát"),
              onPressed: () async {
                await SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ).then((value) => value ?? false);
    }

    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          // do stuff here based on BlocA's state
          final formStatus = state.status;

          if (formStatus == RegisterStatus.failure) {
            _showSnackBar(context, state.message, Colors.red);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => OtpPage(
            //       phoneNumber: _usernameController.text,
            //       screenType: "ActiveSms",
            //     ),
            //   ),
            // );
          }
          if (formStatus == RegisterStatus.success) {
            _showSnackBar(context, state.message, Colors.green);
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            elevation: 0,
            title: Text("Đăng ký"),
          ),
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(
                gradient: gradient.LinearGradient(
              // stops: [0.1, 0.8, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor.withOpacity(0.5),
                kPrimaryColor.withOpacity(0.1)
              ],
            )),
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Stack(alignment: Alignment.center, children: <Widget>[
                // Container(
                //   decoration: BoxDecoration(
                //       gradient: gradient.LinearGradient(
                //     // stops: [0.1, 0.8, 0.9],
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [
                //       kPrimaryColor.withOpacity(0.8),
                //       kPrimaryColor.withOpacity(0.1)
                //     ],
                //   )),
                //   width: double.infinity,
                //   height: size.height,
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ScaleTransition(
                        scale: Tween(begin: 0.2, end: 1.0).animate(
                            CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.bounceOut)),
                        child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Image.asset("images/Logo_truong.png",
                                height: size.height * 0.2))),
                    RoundedInputField(
                      hintText: "Số điện thoại",
                      onChanged: (value) {},
                      controller: _usernameController,
                    ),
                    RoundedInputField(
                      hintText: "Họ tên",
                      // icon: Icon,
                      onChanged: (value) {},
                      controller: _partnerNameController,
                    ),
                    RoundedInputField(
                      hintText: "Địa chỉ",
                      icon: Icons.place,
                      onChanged: (value) {},
                      controller: _addressController,
                    ),
                    RoundedPasswordField(
                      hintText: "Mật khẩu",
                      // icon: Icon,
                      onChanged: (value) {},
                      controller: _passwordController,
                    ),
                    RoundedPasswordField(
                      hintText: "Nhập lại mật khẩu",
                      // icon: Icon,
                      onChanged: (value) {},
                      controller: _confirmPasswordController,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isAgree,
                            onChanged: (value) async {
                              setState(() {
                                isAgree = value!;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Wrap(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Tôi đã xem và đồng ý với các ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            InkWell(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WebViewPage(
                                          title: 'CHÍNH SÁCH QUYỀN RIÊNG TƯ',
                                          url:
                                              'https://edupay.vn/chinh-sach-va-dieu-khoan-su-dung-edupay/'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Chính sách và điều khoản.',
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 150, 243, .9),
                                      decoration: TextDecoration.underline,
                                      fontSize: 16),
                                )),
                          ],
                        ))
                      ],
                    ),
                    RoundedButton(
                      enable: isAgree,
                      text: "Tạo tài khoản",
                      press: () {
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                        } else {
                          context.read<RegisterBloc>().add(RegisterSubmitted(
                              phoneNumber: _usernameController.text,
                              partnerName: _partnerNameController.text,
                              address: _addressController.text,
                              password: _passwordController.text,
                              companyCode: Profile.companyCode));
                        }
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: color);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
