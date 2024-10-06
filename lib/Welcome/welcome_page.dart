import 'package:edupay/constants.dart';
import 'package:edupay/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/base/base_view_view_model.dart';
import '../routes/app_pages.dart';
import 'welcome_page_controller.dart';

class WelcomePage extends BaseView<WelcomePageController> {
  @override
  Widget baseBuilder(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background/background-1.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22))),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Chào mừng đến với EduPay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Ứng dụng kết nối thông tin giữa phụ huynh, học sinh và nhà trường.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            buttonWelcome(
                image: 'images/icon/parent.png',
                title: 'Tôi là phụ huynh',
                onTap: () {
                  Profile.typeUser = 1;
                  Get.toNamed(Routes.LOGIN);
                }),
            buttonWelcome(
                image: 'images/icon/teacher-desk.png',
                title: 'Tôi là giáo viên',
                onTap: () {
                  Profile.typeUser = 2;
                  Get.toNamed(Routes.LOGIN);
                }),
            // Add more containers here as needed
          ],
        ));
  }

  GestureDetector buttonWelcome(
      {String? image, String? title, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        // width: size.width,
        // height: 50,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kPrimaryColor.withOpacity(0.3), width: 2),
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(
                flex: 20,
                child: Image.asset(
                  image!,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                  flex: 80,
                  child: Text(
                    title ?? "",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
