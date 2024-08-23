import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as gradient;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../HomePageTeacher/homepage_tearcher.dart';
import '../Homepage/homepage.dart';
import '../Register/register_screen.dart';
import '../config/DataService.dart';
import '../constants.dart';
import '../models/configuration.dart';
import '../models/profile.dart';
import '../widget/rounded_button.dart';
import '../widget/rounded_input_field.dart';
import '../widget/rounded_password_field.dart';
import 'bloc/form_status.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation sizeAnimation;
  late Size size;
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  late Configuration configuration = Configuration();
  late String version = "";
  late String code = "";
  bool warningVersion = false;
  String appVersion = "";
  String platform = 'Android';

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'iOS';
    }

    version = packageInfo.version;
    code = packageInfo.buildNumber;

    appVersion = version + "+" + code;
    if (Platform.isAndroid) {
      await NetworkService()
          .getVersion("Android", Profile.companyCode)
          .then((value) {
        if (value.data != null) {
          configuration = value.data!;
          if (appVersion != value.data!.configurationValue) {
            warningVersion = true;
          }
        }
      });
    } else {
      await NetworkService()
          .getVersion("iOS", Profile.companyCode)
          .then((value) {
        if (value.data != null) {
          configuration = value.data!;
          if (appVersion != value.data!.configurationValue) {
            warningVersion = true;
          }
        }
      });
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _getVersion();
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

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // do stuff here based on BlocA's state
          final formStatus = state.formStatus;

          if (formStatus is FormSubmitFailed) {
            _showSnackBar(context, state.message, Colors.red);
          }
          if (formStatus is FormSubmitSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageScreen(
                          warningLog: warningVersion,
                        )));
          }
             if (formStatus is FormSubmitSuccessTeacher) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageTeacherScreen(
                          // warningLog: warningVersion,
                        )));
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
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
              width: double.infinity,
              height: size.height,
              child: Stack(alignment: Alignment.center, children: <Widget>[
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
                                height: size.height * 0.24))),
                    RoundedInputField(
                      hintText: "Số điện thoại",
                      onChanged: (value) {
                        // context.read<LoginBloc>().add(
                        //     LoginUsernameChanged(userName: _usernameController.text));
                      },
                      controller: _usernameController,
                    ),
                    RoundedPasswordField(
                      hintText: "Mật khẩu",
                      onChanged: (value) {
                        // context.read<LoginBloc>().add(
                        //     LoginPasswordChanged(password: _passwordController.text));
                        // _passwordController.text = value;
                      },
                      controller: _passwordController,
                    ),
                    RoundedButton(
                      text: "Đăng nhập",
                      press: () {
                        context.read<LoginBloc>().add(LoginSubmitted(
                            userName: _usernameController.text,
                            password: _passwordController.text));
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Chưa có tài khoản? ",
                                style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 5.0),
                                        blurRadius: 8.0,
                                        color: Colors.white54,
                                      ),
                                    ],
                                    color: Color.fromRGBO(0, 0, 0, .9),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans')),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: Text("Đăng ký ngay!",
                                  style: TextStyle(
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0.0, 5.0),
                                          blurRadius: 8.0,
                                          color: Colors.white54,
                                        ),
                                      ],
                                      color: kPrimaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans')),
                            )
                          ],
                        )),
                    SizedBox(height: 40),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Phiên bản: ${version}+${code}',
                                style: TextStyle(
                                    // shadows: <Shadow>[
                                    //   Shadow(
                                    //     offset: Offset(0.0, 5.0),
                                    //     blurRadius: 8.0,
                                    //     color: Color.fromARGB(
                                    //         50, 50, 50, 255),
                                    //   ),
                                    // ],
                                    color: Colors.grey[800],
                                    fontSize: 16.0,
                                    fontFamily: 'OpenSans')),
                            Visibility(
                              visible: warningVersion,
                              child: Text(
                                  '(${configuration == null ? '' : configuration.configurationValue})',
                                  style: TextStyle(
                                      // shadows: <Shadow>[
                                      //   Shadow(
                                      //     offset: Offset(0.0, 5.0),
                                      //     blurRadius: 8.0,
                                      //     color: Color.fromARGB(
                                      //         50, 50, 50, 255),
                                      //   ),
                                      // ],
                                      color: Colors.red,
                                      fontSize: 16.0,
                                      fontFamily: 'OpenSans')),
                            )
                          ],
                        )),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: color);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
