import 'package:edupay/Login/login.dart';
import 'package:edupay/Welcome/welcome_page.dart';
import 'package:edupay/Welcome/welcome_page_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Homepage/home_page_parent.dart';
import '../Homepage/home_page_parent_controller.dart';
import '../Login/login_page.dart';
import '../Login/login_page_controller.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomePageBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.HOMEPAGEPARENT,
      page: () => HomePageParent(),
      binding: HomePageParentBinding(),
    ),

    ///
  ];
}
