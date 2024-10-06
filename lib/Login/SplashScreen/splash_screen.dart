import 'package:edupay/Login/login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'dart:io';
import '../../Homepage/homepage.dart';
import '../../config/DataService.dart';
import '../../constants.dart';
import '../../models/configuration.dart';
import '../../models/profile.dart';
import '../../models/secure_store.dart';
import '../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final secureStore = SecureStore();
  var loginController =
      Get.put(LoginPageController()); // Khởi tạo LoginController
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
      await Future.delayed(const Duration(milliseconds: 2000))
          .then((value) => (value) => Get.offAllNamed(Routes.WELCOME));
    } else {
      if (userLogin == "" || userLogin == null) {
        await Future.delayed(const Duration(milliseconds: 2000))
            .then((value) => Get.offAllNamed(Routes.WELCOME));
      } else {
        await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
            loginController.loginSplashScreen(
                phoneNumber: userLogin, pass: plantextPassword));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.withOpacity(0.5), Colors.orange.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(children: [
        Positioned(
            top: size.height * 0.2,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: size.width,
                  width: size.width,
                  child: Image.asset('images/Logo_truong.png')),
            )),
      ]),
    ));
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: color);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
