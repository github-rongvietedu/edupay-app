import 'package:bts_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PersonInfoScreen extends StatefulWidget {
  const PersonInfoScreen({Key? key}) : super(key: key);

  @override
  State<PersonInfoScreen> createState() => _PersonInfoScreenState();
}

class _PersonInfoScreenState extends State<PersonInfoScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thông tin cá nhân"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 60,
                  width: size.width,
                  color: Colors.white,
                  child: Row(children: [
                    Text("Họ tên:", style: TextStyle(fontSize: 16)),
                    Flexible(
                      child: TextField(
                        controller: controller,
                      ),
                    ),
                  ]),
                ),
              ],
            )));
  }
}
