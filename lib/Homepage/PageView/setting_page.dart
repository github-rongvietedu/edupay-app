import 'package:edupay/ChangePassword/change_password.dart';
import 'package:edupay/Login/login_page.dart';
import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/secure_store.dart';
import '../../routes/app_pages.dart';
import '../../utilities.dart';
import '../../widget/confirm_delete.dart';
import '../../widget/webViewPage.dart';

class SettingScreen extends StatelessWidget {
  final secureStore = SecureStore();

  final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ');

  onBackPressed() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cài đặt',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            // color: Colors.black,
          ),
        ),
        centerTitle: true,
        // backgroundColor: kPrimaryColor,
        leading: SizedBox(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 10),
            child: Text('Tài khoản',
                textAlign: TextAlign.start,
                style: textInter14.blackColor.copyWith(
                  fontWeight: FontWeight.w900,
                )),
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildButtonSetting(
                    decoration: BoxDecoration(color: Colors.white),
                    title: 'Đổi mật khẩu',
                    iconWidget: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'res/icons/bulk/lock-circle.svg',
                          width: 30,
                          height: 30,
                          colorFilter: ColorFilter.mode(
                              kPrimaryColor.withOpacity(0.8), BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     // builder: (context) => ChangePassword(),
                      //   ),
                      // );
                    }),
              ],
            ),
          ),

          /// Title 2
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 10),
            child: Text('Hỗ trợ',
                textAlign: TextAlign.start,
                style: textInter14.blackColor.copyWith(
                  fontWeight: FontWeight.w900,
                )),
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildButtonSetting(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    title: 'Điều khoản EduPay',
                    iconWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.privacy_tip_outlined,
                              size: 30, color: kPrimaryColor.withOpacity(0.8)),
                          const SizedBox(
                            width: 12,
                          )
                        ]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WebViewPage(
                              title: 'CHÍNH SÁCH QUYỀN RIÊNG TƯ',
                              url:
                                  'https://edupay.vn/chinh-sach-va-dieu-khoan-su-dung-edupay'),
                        ),
                      );
                      // Get.to(PolicyPage());
                    }),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmDelete(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'res/icons/bulk/profile-delete.svg',
                            width: 30,
                            height: 30,
                            colorFilter: ColorFilter.mode(
                                kPrimaryColor.withOpacity(0.6),
                                BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text("Xóa tài khoản",
                              style: textInter14.bold.redColor),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp,
                              size: 16, color: Colors.grey[500]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
              // alignment: FractionalOffset.bottomCenter,
              child: MaterialButton(
            onPressed: () async {
              await secureStore.deleteSecureData('email');
              await secureStore.deleteSecureData('password');
              await secureStore.deleteSecureData('lastLogin');

              Get.offAllNamed(Routes.WELCOME);
              // Navigator.pushAndRemoveUntil<dynamic>(
              //   context,
              //   MaterialPageRoute<dynamic>(
              //     builder: (BuildContext context) => LoginPage(),
              //   ),
              //   (route) =>
              //       false, //if you want to disable back feature set to false
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  )),
              width: MediaQuery.of(context).size.width,
              height: 45,
              child:
                  Center(child: Text('Đăng xuất', style: textInter16.redColor)),
            ),
          )),
        ],
      ),
    );
  }

  GestureDetector buildButtonSetting({
    Widget? iconWidget,
    Decoration? decoration,
    required title,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // color: Colors.red,

        decoration: decoration,
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // if (icon != null && icon!.isNotEmpty)
              //   Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SvgPicture.asset(
              //         icon,
              //         width: 30,
              //         height: 30,
              //         colorFilter: ColorFilter.mode(
              //             kPrimaryColor.withOpacity(0.8), BlendMode.srcIn),
              //       ),
              //       const SizedBox(
              //         width: 12,
              //       ),
              //     ],
              //   ),
              iconWidget ?? SizedBox(),
              Text(title, style: textInter14.bold.blackColor),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,
                  size: 16, color: Colors.grey[500]),
            ],
          ),
        ),
      ),
    );
  }
}

Widget settingItem(BuildContext context,
    {String? title, void Function()? onTap, Icon? icon, String url = ""}) {
  return GestureDetector(
      child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 26, right: 14, bottom: 10),
        decoration: BoxDecoration(
            // color:Colors.red,
            border: Border(
                bottom: BorderSide(
          width: 0.4,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            url.isNotEmpty &&
                    (url.endsWith('jpg') ||
                        url.endsWith('png') ||
                        url.endsWith('gif'))
                ? ImageIcon(
                    NetworkImage(
                      url,
                    ),
                    size: 30,
                    color: Colors.grey[500],
                  )
                : icon ?? SizedBox.shrink(),
            SizedBox(
              width: 20,
            ),
            Text(title ?? "",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Spacer(),
            Icon(Icons.arrow_forward_ios_sharp,
                size: 16, color: Colors.grey[500]),
          ],
        ),
      ),
      onTap: onTap);
}

// Future<bool> _onBackPressed() async {
//   return showConfirmDialog(
//         context: context,
//         // height: 120,
//         // icon: RiveAnimation.asset("images/icon/DK_Now.riv"),
//         // icon: Image.asset('assets/images/icons/question-mark.png'),
//         message: 'Bạn có muốn đăng xuất khỏi tài khoản?',
//         // messageStyle: text16.blackColor,
//         cancelTitle: "Quay Lại",
//         submitTitle: 'Thoát',
//         // submitTitleStyle: ,
//         onCancel: () async {
//           Navigator.of(context).pop(false);
//         },
//         onSubmit: () async {
//           await secureStore.deleteSecureData('email');
//           await secureStore.deleteSecureData('password');
//           await secureStore.deleteSecureData('lastLogin');
//           Navigator.pushAndRemoveUntil<dynamic>(
//             context,
//             MaterialPageRoute<dynamic>(
//               builder: (BuildContext context) => LoginPage(),
//             ),
//             (route) => false, //if you want to disable back feature set to false
//           );
//         },
//       ) ??
//       false;

  // showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         // title:  Text('Rồng Việt'),
  //         content:  Text('Bạn có muốn đăng xuất khỏi tài khoản?'),
  //         actions: <Widget>[
  //           TextButton(
  //             child:  Text("Quay lại"),
  //             onPressed: () async {
  //               Navigator.of(context).pop(false);
  //             },
  //           ),
  //           TextButton(
  //             child:  Text("Đăng xuất",
  //                 style: TextStyle(color: Colors.redAccent)),
  //             onPressed: () async {
  //               await secureStore.deleteSecureData('email');
  //               await secureStore.deleteSecureData('password');
  //               await secureStore.deleteSecureData('lastLogin');
  //               Navigator.pushAndRemoveUntil<dynamic>(
  //                 context,
  //                 MaterialPageRoute<dynamic>(
  //                   builder: (BuildContext context) =>  LoginPage(),
  //                 ),
  //                 (route) =>
  //                     false, //if you want to disable back feature set to false
  //               );
  //             },
  //           ),
  //           // new GestureDetector(

  //           //   onTap: () async {
  //           //     await SystemChannels.platform
  //           //         .invokeMethod<void>('SystemNavigator.pop');
  //           //   },
  //           //   child: Text("YES"),
  //           // ),
  //         ],
  //       ),
  //     ) ??
  //     false;

