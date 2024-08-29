import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thông tin liên hệ"),
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            height: size.height * 0.85,
            width: size.width,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.25,
                  width: size.width * 0.8,
                  child: Image.asset("images/robotviet-logo.png"),
                ),
                Text("CÔNG TY CỔ PHẦN GIÁO DỤC VÀ KHOA HỌC ỨNG DỤNG ROBOT VIỆT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 20),
                Container(
                    // color: Colors.red,
                    height: size.height * 0.05,
                    width: size.width,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Image.asset(
                              "images/icon/placeholder.png",
                              height: 32,
                              width: 32,
                            )),
                        Expanded(
                            flex: 9,
                            child: Text(
                                "122 Phan Xích Long, Phường 3, Quận Bình Thạnh, Thành Phố Hồ Chí Minh",
                                style: TextStyle(fontSize: 18)))
                      ],
                    )),
                Container(
                    // color: Colors.red,
                    height: size.height * 0.05,
                    width: size.width,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Image.asset(
                              "images/icon/email.png",
                              height: 32,
                              width: 32,
                            )),
                        Expanded(
                            flex: 9,
                            child: Text("robotviet.rve@gmail.com",
                                style: TextStyle(fontSize: 18)))
                      ],
                    ))
              ],
            )));
  }
}
