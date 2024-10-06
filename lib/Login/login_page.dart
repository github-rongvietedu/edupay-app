import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/painting.dart' as gradient;

import '../config/DataService.dart';
import '../constants.dart';
import '../core/base/base_view_view_model.dart';
import '../models/configuration.dart';
import '../models/profile.dart';
import '../widget/rounded_button.dart';
import '../widget/rounded_input_field.dart';
import '../widget/rounded_password_field.dart';
import 'login_page_controller.dart';

class LoginPage extends BaseView<LoginPageController> {
  @override
  Widget baseBuilder(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.5),
                Colors.orange.withOpacity(0.1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Obx(
            () {
              if (controller.onInitPage.value) {
                return SizedBox();
              } else {
                return _buildBody(context);
              }
            },
          )),
    );
  }

  Widget _buildBody(context) {
    return Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context)
                    .size
                    .height, // Ensure minimum height to fill screen
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, // Adjust based on keyboard
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ScaleTransition(
                        scale: Tween(begin: 0.1, end: 1.0).animate(
                            CurvedAnimation(
                                parent: controller.animationController,
                                curve: Curves.bounceOut)),
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Image.asset("images/Logo_truong.png",
                                height: controller.size.height * 0.24))),
                    SizedBox(height: 15),
                    RoundedInputField(
                      hintText: "Số điện thoại",
                      onChanged: (value) {
                        // context.read<LoginBloc>().add(
                        //     LoginUsernameChanged(userName: _usernameController.text));
                      },
                      controller: controller.usernameController,
                    ),
                    RoundedPasswordField(
                      hintText: "Mật khẩu",
                      onChanged: (value) {
                        // context.read<LoginBloc>().add(
                        //     LoginPasswordChanged(password: _passwordController.text));
                        // _passwordController.text = value;
                      },
                      controller: controller.passwordController,
                    ),
                    SizedBox(height: 5),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Text("Quên mật khẩu?",
                    //       textAlign: TextAlign.end,
                    //       style: TextStyle(
                    //           shadows: <Shadow>[
                    //             Shadow(
                    //               offset: Offset(0.0, 5.0),
                    //               blurRadius: 8.0,
                    //               color: Colors.white54,
                    //             ),
                    //           ],
                    //           color: kPrimaryColor,
                    //           fontSize: 12.0,
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: 'OpenSans')),
                    // ),
                    // SizedBox(height: 20),
                    RoundedButton(
                      text: "Đăng nhập",
                      press: () async {
                        await controller.login();
                        // context.read<LoginBloc>().add(LoginSubmitted(
                        //     userName: _usernameController.text,
                        //     password: _passwordController.text));
                      },
                    ),
                    // Container(
                    //     padding: EdgeInsets.symmetric(vertical: 0.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         Text("Chưa có tài khoản? ",
                    //             style: TextStyle(
                    //                 shadows: <Shadow>[
                    //                   Shadow(
                    //                     offset: Offset(0.0, 5.0),
                    //                     blurRadius: 8.0,
                    //                     color: Colors.white54,
                    //                   ),
                    //                 ],
                    //                 color: Color.fromRGBO(0, 0, 0, .9),
                    //                 fontSize: 16.0,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontFamily: 'OpenSans')),
                    //         GestureDetector(
                    //           onTap: () {
                    //             // Navigator.push(
                    //             //     context,
                    //             //     MaterialPageRoute(
                    //             //         builder: (context) =>
                    //             //             const RegisterScreen()));
                    //           },
                    //           child: Text("Đăng ký ngay!",
                    //               style: TextStyle(
                    //                   shadows: <Shadow>[
                    //                     Shadow(
                    //                       offset: Offset(0.0, 5.0),
                    //                       blurRadius: 8.0,
                    //                       color: Colors.white54,
                    //                     ),
                    //                   ],
                    //                   color: kPrimaryColor,
                    //                   fontSize: 16.0,
                    //                   fontWeight: FontWeight.bold,
                    //                   fontFamily: 'OpenSans')),
                    //         )
                    //       ],
                    //     )),
                    SizedBox(height: 10),
                    Obx(
                      () => Container(
                          padding: EdgeInsets.symmetric(vertical: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'Phiên bản: ${controller.version.value}+${controller.code.value}',
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
                                visible: controller.warningVersion,
                                child: Text(
                                    '(${controller.configuration == null ? '' : controller.configuration.configurationValue})',
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
