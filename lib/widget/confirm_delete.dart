import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Login/body.dart';
import '../config/DataService.dart';
import '../constants.dart';
import '../models/profile.dart';
import '../models/secure_store.dart';
import 'rounded_button.dart';
import 'rounded_input_field.dart';
import 'text_with_dot.dart';

class ConfirmDelete extends StatefulWidget {
  const ConfirmDelete({Key? key}) : super(key: key);

  @override
  State<ConfirmDelete> createState() => _ConfirmDeleteState();
}

class _ConfirmDeleteState extends State<ConfirmDelete> {
  final _textController = TextEditingController();
  bool isAgree = false;
  final secureStore = SecureStore();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Xoá tài khoản"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
            padding: EdgeInsets.all(8),
            width: size.width,
            height: size.height,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  "Bạn muốn xoá tài khoản? Việc xoá tài khoản sẽ ảnh hưởng đến việc sử dụng ứng dụng như thế nào, xin vui lòng đọc các thông tin sau.",
                  style: TextStyle(fontSize: 18)),
              Text("Tài Khoản",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextWithDot(
                  text: "Bạn sẽ không thể kích hoạt lại tài khoản.",
                  style: TextStyle(fontSize: 18)),
              TextWithDot(
                  text:
                      "Mọi thông tin cá nhân của bạn đều bị xoá khỏi hệ thống của chúng tôi.",
                  style: TextStyle(fontSize: 18)),
              TextWithDot(
                  text:
                      "Bạn có thể đăng ký lại số điện thoại này, nhưng sẽ không sử dụng được ứng dụng vì thiếu một số thông tin liên kết.",
                  style: TextStyle(fontSize: 18)),
              Text("Xác nhận xoá tài khoản",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Nhập chữ ", style: TextStyle(fontSize: 18)),
                    TextSpan(
                        text: 'YES',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    TextSpan(
                        text: ' để xác nhận xoá tài khoản',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Center(
                child: RoundedInputField(
                    icon: Icons.cancel,
                    hintText: "Nhập chữ để xác nhận",
                    onChanged: ((value) {
                      if (value.toUpperCase() == "YES") {
                        isAgree = true;
                      } else {
                        isAgree = false;
                      }
                      setState(() {});
                    }),
                    controller: _textController),
              ),
              Center(
                child: RoundedButton(
                  enable: isAgree,
                  text: "Xoá tài khoản",
                  press: () async {
                    final deleteSuccess = await DataService().deleteAccount(
                        Profile.phoneNumber ?? "", Profile.companyCode);
                    if (deleteSuccess == false) {
                      // ScaffoldMessenger.of(context)
                      //   ..hideCurrentSnackBar()
                      //   ..showSnackBar(SnackBar(
                      //       backgroundColor: Colors.red,
                      //       content: const Text(
                      //           "Xoá tài khoản không thành công !!!",
                      //           style: TextStyle(color: Colors.white))));
                    } else {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: const Text("Xoá tài khoản thành công.",
                                style: TextStyle(color: Colors.white))));
                      _logout();
                    }
                  },
                ),
              ),
            ])));
  }

  _logout() async {
    await secureStore.deleteSecureData('userlogin');
    await secureStore.deleteSecureData('password');
    await secureStore.deleteSecureData('selectedStudent');
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const BodyLogin(),
      ),
      (route) => false, //if you want to disable back feature set to false
    );
  }
}
