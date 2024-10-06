import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/base/base_controller.dart';
import '../config/DataService.dart';
import '../models/configuration.dart';
import '../models/loginModel/loginModel.dart';
import '../models/loginModel/loginmodelresult.dart';
import '../models/profile.dart';
import '../models/secure_store.dart';
import '../routes/app_pages.dart';
import '../utilities.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }
}

class LoginPageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final secureStore = SecureStore();
  late AnimationController animationController;
  late Animation sizeAnimation;
  Size size = MediaQuery.of(Get.context!).size;
  final passwordController = TextEditingController(text: "");
  final usernameController = TextEditingController(text: "");

  Configuration configuration = Configuration();
  var version = "".obs;
  var code = "".obs;
  bool warningVersion = false;
  var appVersion = "".obs;
  String platform = 'Android';
  var onInitPage = true.obs;

  @override
  void onInit() async {
    await getVersion();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    sizeAnimation = Tween<double>(begin: 100, end: 270).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));
    setOnInit(false);
    animationController.forward();

    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> setOnInit(bool onInitPage) async {
    this.onInitPage.value = onInitPage;
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'iOS';
    }
    version.value = packageInfo.version;
    code.value = packageInfo.buildNumber;
    appVersion.value = version.value + "+" + code.value;
    if (Platform.isAndroid) {
      await DataService()
          .getVersion("Android", Profile.companyCode)
          .then((value) {
        if (value.data != null) {
          configuration = value.data!;
          if (appVersion.value != value.data!.configurationValue) {
            warningVersion = true;
          }
        }
      });
    } else {
      await DataService().getVersion("iOS", Profile.companyCode).then((value) {
        if (value.data != null) {
          configuration = value.data!;
          if (appVersion.value != value.data!.configurationValue) {
            warningVersion = true;
          }
        }
      });
    }
  }

  Future<void> loginSplashScreen(
      {required String phoneNumber, required String pass}) async {
    DataService dataService = DataService();
    try {
      final dataResponse = await loadingDialog.showLoadingPopup(
          Get.context!,
          dataService.login(
              phoneNumber: phoneNumber,
              password: pass,
              firebaseToken: await FirebaseMessaging.instance.getToken(),
              appVersion: ''),
          loadingText: "test");

      LoginModelResult loginModelResult =
          LoginModelResult.fromJson(dataResponse);
      final message = dataResponse['message'] ?? '';
      if (dataResponse['status'] == 2) {
        String userName = phoneNumber;
        String password = pass;
        Profile.phoneNumber = userName;
        secureStore.writeSecureData('userlogin', userName ?? "");

        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        Profile.parentID = dataResponse['user']['ID'];

        String passwordEncoded = stringToBase64.encode(password ?? "");
        secureStore.writeSecureData('password', passwordEncoded);
        secureStore.writeSecureData('userType', '1');
        DateTime now = DateTime.now();
        String valueDate = DateFormat('yyyy-MM-dd').format(now);
        secureStore.writeSecureData('lastLogin', valueDate);

        loginModelResult.message = "Đăng nhập thành công !!!";
        if (loginModelResult.listStudent!.isNotEmpty) {
          int index = 0;
          loginModelResult.listStudent?.forEach((element) {
            Profile.listStudent[index++] = element;
          });
        }
        Get.offAndToNamed(Routes.HOMEPAGEPARENT);
      } else {
        Get.offAndToNamed(Routes.WELCOME);
      }
    } catch (e) {
      print(e);
      Get.offAndToNamed(Routes.WELCOME);
    }
  }

  Future<void> login() async {
    DataService dataService = DataService();
    try {
      final dataResponse = await loadingDialog.showLoadingPopup(
          Get.context!,
          dataService.login(
              phoneNumber: usernameController.text,
              password: passwordController.text,
              firebaseToken: await FirebaseMessaging.instance.getToken(),
              appVersion: ''),
          loadingText: "test");

      LoginModelResult loginModelResult =
          LoginModelResult.fromJson(dataResponse);
      final message = dataResponse['message'] ?? '';
      if (dataResponse['status'] == 2) {
        String userName = usernameController.text;
        String password = passwordController.text;
        Profile.phoneNumber = userName;
        secureStore.writeSecureData('userlogin', userName ?? "");

        Codec<String, String> stringToBase64 = utf8.fuse(base64);
        Profile.parentID = dataResponse['user']['ID'];

        String passwordEncoded = stringToBase64.encode(password ?? "");
        secureStore.writeSecureData('password', passwordEncoded);
        secureStore.writeSecureData('userType', '1');
        DateTime now = DateTime.now();
        String valueDate = DateFormat('yyyy-MM-dd').format(now);
        secureStore.writeSecureData('lastLogin', valueDate);

        loginModelResult.message = "Đăng nhập thành công !!!";
        if (loginModelResult.listStudent!.isNotEmpty) {
          int index = 0;
          loginModelResult.listStudent?.forEach((element) {
            Profile.listStudent[index++] = element;
          });
        }
        Get.toNamed(Routes.HOMEPAGEPARENT);
      } else {
        Get.snackbar("Thông báo", message);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Thông báo", "Tài khoản hoặc mật khẩu không đúng");
    }
  }
}
