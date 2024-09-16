import 'dart:convert';
import 'dart:io';

import 'package:edupay/HomePageTeacher/homepage_tearcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart' as gradient;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../Homepage/homepage.dart';
import '../config/DataService.dart';
import '../constants.dart';
import '../models/configuration.dart';
import '../models/profile.dart';
import '../models/secure_store.dart';
import 'bloc/form_status.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';
import 'body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final secureStore = SecureStore();
  String userLogin = "";
  String plantextPassword = "";
  bool expiredDate = false;
  late DateTime lastDate;
  late Configuration configuration = Configuration();
  late String version = "";
  late String code = "";
  bool warningVersion = false;
  String platform = 'Android';
  String appVersion = "";
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
    await DataService().getVersion(platform, Profile.companyCode).then((value) {
      if (value.data != null) {
        configuration = value.data!;
        if (appVersion != value.data!.configurationValue) {
          warningVersion = true;
        }
      }
    });
  }

  Future<void> _checkLoginStatus() async {
    String endcodepassword = "";

    await secureStore.readSecureData('userlogin').then((value) {
      if (value != null && value != "") {
        userLogin = value;
      }
    });
    await secureStore.readSecureData('password').then((value) {
      if (value != null && value != "") {
        endcodepassword = value;
      }
    });
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    if (endcodepassword != '') {
      plantextPassword = stringToBase64.decode(endcodepassword);
    }

    await secureStore.readSecureData('selectedStudent').then((value) {
      if (value != null && value != "") {
        Profile.selectedStudent = int.tryParse(value) ?? 0;
      }
    });
    secureStore.readSecureData('lastLogin').then((value) {
      if (value != null && value.toString() != "") {
        lastDate = DateTime.parse(value);

        if (DateTime.now().difference(lastDate).inDays > 10) {
          expiredDate = true;
        }
      }
    });

    _getVersion();

    if (expiredDate == true) {
      await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const BodyLogin())));
    } else {
      if (userLogin == "" || userLogin == null) {
        await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const BodyLogin())));
      } else {
        await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
            context.read<LoginBloc>().add(LoginSubmitted(
                userName: userLogin, password: plantextPassword)));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          final formStatus = state.formStatus;

          if (formStatus is FormSubmitFailed) {
            _showSnackBar(context, state.message, Colors.red);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const BodyLogin()));
          }
          if (formStatus is FormSubmitSuccess) {
            Navigator.pushReplacement(
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
        child: Stack(children: [
          Container(
              height: size.height, width: size.width, color: kPrimaryColor),
          Positioned(
              top: size.height * 0.2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    // color: Colors.red,
                    padding: EdgeInsets.all(20),
                    height: size.width,
                    width: size.width,
                    child: Image.asset('images/Logo_truong.png')),
              )),
          // Positioned(
          //     bottom: size.height * 0.1,
          //     child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Container(
          //         // color: Colors.red,
          //         height: size.height,
          //         width: size.width,
          //         child: RiveAnimation.asset('images/riv/text.riv',
          //             animations: [], fit: BoxFit.cover),
          //       ),
          //     )),
        ]),
        //  const RiveAnimation.asset('images/riv/loading1.riv',
        //     animations: [], fit: BoxFit.fill),
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
