import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import '../../core/base/base_controller.dart';

class WelcomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomePageController());
  }
}

class WelcomePageController extends BaseController {
  static TextEditingController userNameController =
      TextEditingController(text: '');
  static TextEditingController passwordController =
      TextEditingController(text: '');
  static TextEditingController companyController =
      TextEditingController(text: '');
  @override
  void onInit() async {
    super.onInit();
  }

  static Future<String> login() async {
    // Add a return statement here
    return '';
  }

  static Future<void> logOut() async {}
}
