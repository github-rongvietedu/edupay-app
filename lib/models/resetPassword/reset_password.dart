import 'package:flutter/material.dart';

import '../../config/networkservice.dart';
import '../../constants.dart';
import '../../utils.dart';
import '../../widget/custom_button.dart';
import '../../widget/fade_slide_transition.dart';
import '../resetpasswordmodel.dart';
import 'otp_page.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ResetPasswordScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<ResetPasswordScreen> {
  // late Animation<double> animation;
  // late Animation<double> _headerTextAnimation;
  bool isAgree = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    // animation = widget.animation!;
    // final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    // _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
    //   parent: animation,
    //   curve: const Interval(
    //     0.0,
    //     0.6,
    //     curve: Curves.easeInOut,
    //   ),
    // ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final authenticationRepository = AuthenticationRepository();
    // authenticationRepository.user.first;
    final size = MediaQuery.of(context).size;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;
    return Form(
      key: _formKey,
      child: Center(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: size.height * 5 / 100,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                    height: size.height,
                    width: size.width,
                    padding: EdgeInsets.all(10),
                    child: Column(children: <Widget>[
                      SizedBox(height: 100),
                      // Header(animation: _headerTextAnimation),
                      // const Logo(
                      //   color: primaryColor,
                      //   size: 140.0,
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text("Quên mật khẩu",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor))),
                      Text(
                          "Hệ thống sẽ gửi mã OTP thiết lập lại mật khẩu tới Số điện thoại của bạn."),
                      const SizedBox(
                        height: 100,
                      ),

                      ValidationInputField(
                        controller: emailController,
                        hintText: "Số điện thoại",
                        prefixIcon: Icon(
                          Icons.phone,
                          color: kBlack.withOpacity(0.5),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Không được bỏ trống !!!';
                          }
                          if (isValidEmail(text) == false) {
                            return 'Vui lòng nhập email !';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: space),

                      CustomButton(
                          enable: true,
                          color: primaryColor,
                          textColor: kWhite,
                          text: 'Lấy lại mật khẩu',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              // await AuthenticationRepository().signUp(
                              //     email: emailController.text,
                              //     password: passWordController.text);

                              ResetPasswordResultModel result =
                                  await loadingDialog.showLoadingPopup(
                                      context,
                                      NetworkService().getVerifyCode(
                                        phoneNumber: emailController.text,
                                      ));

                              if (result.status == 2) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OtpPage(
                                          userLogin: emailController.text,
                                          screenType: 'ChangePassword',
                                        )));
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                        content: Text("${result.message}"),
                                        backgroundColor: Colors.redAccent),
                                  );
                              }
                            }
                          })
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ValidationInputField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  const ValidationInputField({
    Key? key,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.obscureText = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(kPaddingM),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: kBlack.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: prefixIcon),
        // validate after each user interaction
        // autovalidateMode: AutovalidateMode.onUserInteraction,

        // The validator receives the text that the user has entered.
        validator: validator
        // (text) {
        //   if (text == null || text.isEmpty) {
        //     return 'Can\'t be empty';
        //   }
        //   if (text.length < 4) {
        //     return 'Too short';
        //   }
        //   return null;
        // },

        );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(content: Text(message), backgroundColor: color);
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
