// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rvsocial/app/app.dart';
// import 'package:rvsocial/config/constants.dart';
// import 'package:rvsocial/config/networkservice.dart';
// import 'package:rvsocial/config/utils.dart';
// import 'package:rvsocial/data/models/User/resetpasswordmodel.dart';
// import 'package:rvsocial/login/authentication_repository.dart';
// import 'package:rvsocial/login/widgets/custom_button.dart';
// import 'package:rvsocial/login/widgets/custom_input_field.dart';
// import 'package:rvsocial/login/widgets/fade_slide_transition.dart';
// import 'package:rvsocial/login/widgets/header.dart';
// import 'package:http/http.dart' as http;
// import '../../../game/sounds/appsound.dart';
// import '../../widgets/secure_store.dart';
// import '../../widgets/webViewPage.dart';
// import '../login_page.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   final String email;
//   final String screenType;
//   const ChangePasswordScreen({Key key, this.email, this.screenType = ""})
//       : super(key: key);
//   // final Animation<double> animation;
//   @override
//   State<ChangePasswordScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<ChangePasswordScreen>
//     with SingleTickerProviderStateMixin {
//   final secureStore = SecureStore();
//   bool isHidden2 = true;
//   bool isHidden = true;
//   bool isHidden1 = true;

//   String screenType = "";
//   final TextEditingController oldPassWordController = TextEditingController();
//   final TextEditingController passWordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   String plantextPassword = "";

//   final _formKey = GlobalKey<FormState>();
//   getPassword() async {
//     Codec<String, String> stringToBase64 = utf8.fuse(base64);
//     // final String email = await secureStore.readSecureData('email');
//     final String endcodepassword = await secureStore.readSecureData('password');
//     if (endcodepassword.isNotEmpty) {
//       plantextPassword = stringToBase64.decode(endcodepassword);
//     }
//   }

//   @override
//   void initState() {
//     //appSound.pauseBackgroundMusic();
//     appSound.muteSound(true);
//     // TODO: implement initState
//     getPassword();

//     setState(() {
//       screenType = widget.screenType;
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String email = widget.email;
//     // final authenticationRepository = AuthenticationRepository();
//     // authenticationRepository.user.first;

//     final size = MediaQuery.of(context).size;
//     final height =
//         MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//     final space = height > 650 ? kSpaceM : kSpaceS;

//     bool validateStructure(String value) {
//       String pattern = r'^(?=.*?[a-zA-z])(?=.*?[0-9]).{6,}$';
//       RegExp regExp = new RegExp(pattern);
//       return regExp.hasMatch(value);
//     }

//     Future<bool> _onBackPressed() async {
//       return await showConfirmDialog1(
//             context: context,
//             height: 120,
//             // icon: RiveAnimation.asset("images/icon/DK_Now.riv"),
//             icon: Image.asset('assets/images/icons/question-mark.png'),
//             message: 'Bạn có chắc là không muốn cập nhật mật khẩu ?',
//             messageStyle: text16.blackColor,
//             cancelTitle: "Quay Lại",
//             submitTitle: 'Có',
//             // submitTitleStyle: ,
//             onCancel: () async {
//               Navigator.of(context).pop(false);
//             },
//             onSubmit: () async {
//               if (screenType == "ChangePassword") {
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                     (Route<dynamic> route) => false);
//                 return;
//               }
//               Navigator.of(context).pop(true);
//               Navigator.of(context).pop(true);
//             },
//           ) ??
//           false;

//       // showDialog(
//       //       context: context,
//       //       builder: (context) => AlertDialog(
//       //         title: Text('Rồng Việt'),
//       //         content: Text('Bạn có chắc là không muốn cập nhật mật khẩu ?'),
//       //         actions: <Widget>[
//       //           TextButton(
//       //             child: Text("Quay lại"),
//       //             onPressed: () async {
//       //               Navigator.of(context).pop(false);
//       //             },
//       //           ),
//       //           TextButton(
//       //             child: Text("Có"),
//       //             onPressed: () async {
//       //               if (screenType == "ChangePassword") {
//       //                 Navigator.of(context).pushAndRemoveUntil(
//       //                     MaterialPageRoute(builder: (context) => LoginPage()),
//       //                     (Route<dynamic> route) => false);
//       //                 return;
//       //               }
//       //               Navigator.of(context).pop(true);
//       //             },
//       //           ),
//       //           // new GestureDetector(
//       //         ],
//       //       ),
//       //     ) ??
//       //     false;
//     }

//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Form(
//         key: _formKey,
//         child: Center(
//           child: Scaffold(
//             body: SingleChildScrollView(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     top: MediaQuery.of(context).viewPadding.top,
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back_ios_new),
//                       onPressed: _onBackPressed,
//                     ),
//                   ),
//                   Container(
//                       height: size.height,
//                       width: size.width,
//                       padding: EdgeInsets.all(10),
//                       child: Column(children: <Widget>[
//                         SizedBox(height: 100),
//                         // Header(animation: _headerTextAnimation),
//                         Text("Đặt lại mật khẩu",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 24,
//                                 color: primaryColor)),
//                         SizedBox(height: 50),
//                         SizedBox(height: space),

//                         screenType != "ChangePassword"
//                             ? ValidationInputField(
//                                 controller: oldPassWordController,
//                                 obscureText: isHidden2,
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       isHidden2 = !isHidden2;
//                                     });
//                                   },
//                                   icon: isHidden2
//                                       ? const Icon(Icons.visibility)
//                                       : const Icon(Icons.visibility_off),
//                                   color: primaryColor,
//                                 ),
//                                 hintText: "Nhập mật khẩu hiện tại",
//                                 prefixIcon: Icon(
//                                   Icons.lock,
//                                   color: kBlack.withOpacity(0.5),
//                                 ),
//                                 validator: (text) {
//                                   if (text != plantextPassword) {
//                                     return 'Sai mật khẩu';
//                                   }
//                                   if (text == null || text.isEmpty) {
//                                     return 'Không được bỏ trống !!!';
//                                   }
//                                   return null;
//                                 },
//                               )
//                             : SizedBox(),

//                         SizedBox(height: space),
//                         ValidationInputField(
//                           controller: passWordController,
//                           hintText: "Mật khẩu mới",
//                           obscureText: isHidden,
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 isHidden = !isHidden;
//                               });
//                             },
//                             icon: isHidden
//                                 ? const Icon(Icons.visibility)
//                                 : const Icon(Icons.visibility_off),
//                             color: primaryColor,
//                           ),
//                           prefixIcon: Icon(
//                             Icons.lock,
//                             color: kBlack.withOpacity(0.5),
//                           ),
//                           validator: (text) {
//                             if (text == null || text.isEmpty) {
//                               return 'Không được bỏ trống !!!';
//                             }
//                             if (text.length < 6) {
//                               return 'Mật khẩu quá ngắn !';
//                             }
//                             if (validateStructure(text) == false) {
//                               return 'Mật khẩu phải từ 6 ký tự trở lên, bao gôm viết chữ và chữ số.(Ví dụ: Abc123)';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: space),
//                         ValidationInputField(
//                           controller: confirmPasswordController,
//                           obscureText: isHidden1,
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 isHidden1 = !isHidden1;
//                               });
//                             },
//                             icon: isHidden1
//                                 ? const Icon(Icons.visibility)
//                                 : const Icon(Icons.visibility_off),
//                             color: primaryColor,
//                           ),
//                           hintText: "Nhập lại mật khẩu mới",
//                           prefixIcon: Icon(
//                             Icons.lock,
//                             color: kBlack.withOpacity(0.5),
//                           ),
//                           validator: (text) {
//                             if (text != passWordController.text) {
//                               return 'Mật khẩu không khớp';
//                             }
//                             if (text == null || text.isEmpty) {
//                               return 'Không được bỏ trống !!!';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: space),
//                         CustomButton(
//                             enable: true,
//                             color: primaryColor,
//                             textColor: kWhite,
//                             text: 'Xác nhận',
//                             onPressed: () async {
//                               if (!NetworkService.isOnline) {
//                                 showWarningNetworkDisconnected(context);
//                                 return;
//                               }

//                               if (_formKey.currentState.validate()) {
//                                 // http.Response response =
//                                 //     await loadingDialog.showLoadingPopup(
//                                 //         context,
//                                 //         NetworkService.register(
//                                 //             email: confirmPasswordController.text,
//                                 //             password: passWordController.text,
//                                 //             // fullName: fullNameController.text,
//                                 //             firebaseToken: ''));

//                                 String newPassword = passWordController.text;
//                                 String confirmPassword =
//                                     confirmPasswordController.text;
//                                 ResetPasswordResultModel result =
//                                     await NetworkService().changePassword(
//                                         email, newPassword, confirmPassword);
//                                 if (result.status == 2) {
//                                   _showSnackBar(
//                                       context,
//                                       "Cập nhật mật khẩu thành công!!!",
//                                       Colors.greenAccent);

//                                   if (screenType != "ChangePassword") {
//                                     Codec<String, String> stringToBase64 =
//                                         utf8.fuse(base64);
//                                     secureStore.writeSecureData('password',
//                                         stringToBase64.encode(newPassword));
//                                     Navigator.of(context).pop();
//                                   } else {
//                                     Codec<String, String> stringToBase64 =
//                                         utf8.fuse(base64);
//                                     String valueDate = DateFormat('yyyy-MM-dd')
//                                         .format(DateTime.now());
//                                     secureStore.writeSecureData('email', email);
//                                     secureStore.writeSecureData('password',
//                                         stringToBase64.encode(newPassword));
//                                     secureStore.writeSecureData(
//                                         'lastLogin', valueDate);

//                                     Navigator.of(context)
//                                         .pushNamedAndRemoveUntil('/',
//                                             (Route<dynamic> route) => false);
//                                     return;
//                                     // Navigator.of(context).pushAndRemoveUntil(
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => LoginPage()),
//                                     //     (Route<dynamic> route) => false);
//                                   }
//                                 } else {
//                                   _showSnackBar(
//                                       context,
//                                       "Cập nhật mật khẩu thất bại!",
//                                       Colors.red);
//                                 }
//                               } else {
//                                 _showSnackBar(
//                                     context,
//                                     "Thông tin cập nhật không hợp lệ!",
//                                     Colors.red);
//                               }
//                             }),
//                       ])),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ValidationInputField extends StatefulWidget {
//   final String Function(String) validator;
//   final Widget prefixIcon;
//   final String hintText;
//   final IconButton suffixIcon;
//   final bool obscureText;

//   final TextEditingController controller;
//   const ValidationInputField({
//     Key key,
//     this.validator,
//     this.prefixIcon,
//     this.hintText,
//     this.obscureText = false,
//     this.controller,
//     this.suffixIcon,
//   }) : super(key: key);

//   @override
//   State<ValidationInputField> createState() => _ValidationInputFieldState();
// }

// class _ValidationInputFieldState extends State<ValidationInputField> {
//   @override
//   Widget build(BuildContext context) {
//     // bool _isHidden = true;

//     // IconButton(
//     //   onPressed: () {
//     //     setState(() {
//     //       _isHidden = !_isHidden;
//     //     });
//     //   },
//     //   icon: !_isHidden
//     //       ? const Icon(Icons.visibility)
//     //       : const Icon(Icons.visibility_off),
//     //   color: primaryColor,
//     // ),
//     return TextFormField(
//         // maxLines: 2,

//         keyboardType: TextInputType.multiline,
//         controller: widget.controller,
//         obscureText: widget.obscureText,
//         decoration: InputDecoration(
//             suffixIcon: widget.suffixIcon,
//             errorMaxLines: 2,
//             contentPadding: const EdgeInsets.all(kPaddingM),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
//             ),
//             hintText: widget.hintText,
//             hintStyle: TextStyle(
//               color: kBlack.withOpacity(0.5),
//               fontWeight: FontWeight.w500,
//             ),
//             prefixIcon: widget.prefixIcon),
//         // validate after each user interaction
//         // autovalidateMode: AutovalidateMode.onUserInteraction,

//         // The validator receives the text that the user has entered.
//         validator: widget.validator);
//   }
// }

// void _showSnackBar(BuildContext context, String message, Color color) {
//   final snackBar = SnackBar(content: Text(message), backgroundColor: color);
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(snackBar);
// }
