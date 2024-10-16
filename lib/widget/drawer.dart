import 'package:edupay/Homepage/home_page_parent.dart';
import 'package:edupay/Login/login_page.dart';
import 'package:edupay/about_us.dart';
import 'package:flutter/material.dart';

import '../ChangePassword/change_password.dart';
import '../Homepage/homepage.dart';
import '../Login/body.dart';
import '../Login/login.dart';
import '../PersonInfo/person_info.dart';
import '../config/DataService.dart';
import '../constants.dart';
import '../leave_application.dart';
import '../listnews.dart';
import '../models/profile.dart';
import '../models/secure_store.dart';
import 'confirm_delete.dart';
import 'webViewPage.dart';

class MyDrawer extends StatefulWidget {
  String activityName;

  MyDrawer(this.activityName);
  @override
  _MyDrawerState createState() => _MyDrawerState(this.activityName);
}

class _MyDrawerState extends State<MyDrawer> {
  final secureStore = SecureStore();
  String activityName;

  _MyDrawerState(this.activityName);
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(top: 20),
              height: 190,
              // width: 500,
              child: Center(
                child: Image.asset(
                  "images/Logo_truong.png",
                  fit: BoxFit.cover,
                  // height: 150,
                  // // width: size.width * 0.7
                  // width: 400,
                  // width: 290,
                ),
              ),
            ),

            activityName == "HomePage"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text("Học viên"),
                          leading: Icon(
                            Icons.supervised_user_circle,
                            color: Color(0xE62196F3),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePageParent(),
                              ),
                            );
                          }),
                      Divider(),
                      ListTile(
                          title: Text("Xin nghỉ phép"),
                          leading: Icon(
                            Icons.checklist,
                            color: kPrimaryColor,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveApplicationScreen(),
                              ),
                            );
                          })
                    ],
                  )
                : SizedBox(),

            // SizedBox(height: 150),
            Divider(),
            // ListTile(
            //     title: Text("Tra cứu học phí"),
            //     leading: Icon(
            //       Icons.search,
            //       color: Colors.green,
            //     ),
            //     onTap: () {
            //       // ShopHocCu.sourcePage = activityName;
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const WebViewPage(
            //                 title: 'Tra cứu học phí',
            //                 url: 'https://tracuu.edupay.vn/home'),
            //           ));
            //     }),
            // Divider(),
            ListTile(
                title: Text("Đổi mật khẩu"),
                leading: Icon(
                  Icons.lock,
                  color: Colors.amber,
                ),
                onTap: () {
                  // ShopHocCu.sourcePage = activityName;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                }),
            Divider(),
            ListTile(
                title: Text("Xoá tài khoản"),
                leading: Icon(
                  Icons.disabled_by_default_rounded,
                  color: Colors.red,
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmDelete(),
                      ),
                    )),

            Divider(),
            ListTile(
                title: Text("Đăng xuất"),
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                onTap: () => _logout()),
            Divider(),
            // Spacer(),
            Container(
              height: 15,
              // color: Colors.red,

              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WebViewPage(
                              title: 'CHÍNH SÁCH QUYỀN RIÊNG TƯ',
                              url:
                                  'https://edupay.vn/chinh-sach-va-dieu-khoan-su-dung-edupay'),
                        ),
                      );
                    },
                    child: const Text(
                      'Chính sách điều khoản',
                      style: TextStyle(
                          color: Color.fromRGBO(33, 150, 243, .9),
                          // decoration: TextDecoration.underline,
                          fontSize: 14),
                    )),
                // VerticalDivider(
                //   color: Colors.black38,
                //   // thickness: 1,
                // ),
                // InkWell(
                //     onTap: () async {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const ContactUsScreen()),
                //       );
                //     },
                //     child: const Text(
                //       'Liên hệ chúng tôi',
                //       style: TextStyle(
                //           color: Color.fromRGBO(33, 150, 243, .9),
                //           // decoration: TextDecoration.underline,
                //           fontSize: 12),
                //     )),
              ]),
            ),
          ],
        ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // title: const Text('Are you sure?'),
            content: const Text(
                'Lưu ý sau khi sử dụng chức năng khoá tài khoản bạn sẽ không thể tiếp tục sử dụng ứng dụng. Nếu có nhu cầu mở khoá tài khoản trong tương lai xin vui lòng liên hệ bộ phận chăm sóc khách hàng.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }

  _logout() async {
    await secureStore.deleteSecureData('userlogin');
    await secureStore.deleteSecureData('password');
    await secureStore.deleteSecureData('selectedStudent');
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => LoginPage(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
  }
}
