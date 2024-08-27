import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/painting.dart' as gradient;

import '../Homepage/homepage.dart';
import '../constants.dart';
import '../models/profile.dart';
import '../widget/rounded_button.dart';
import '../widget/rounded_password.dart';
import 'bloc/change_password_bloc.dart';
import 'bloc/change_password_event.dart';
import 'bloc/change_password_state.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        final status = state.status;

        if (status == ChangePasswordStatus.failure) {
          _showSnackBar(context, state.message, Colors.red);
        }
        if (status == ChangePasswordStatus.success) {
          _showSnackBar(context, state.message, Colors.green);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePageScreen(
                        warningLog: false,
                      )));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ĐỔI MẬT KHẨU"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: gradient.LinearGradient(
              // stops: [0.1, 0.8, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryColor.withOpacity(0.8),
                kPrimaryColor.withOpacity(0.1)
              ],
            )),
            width: double.infinity,
            height: size.height,
            child: Stack(alignment: Alignment.topCenter, children: <Widget>[
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset("images/Logo_truong.png",
                          height: size.height * 0.24)),
                  RoundedPassword(
                    hintText: "Mật khẩu hiện tại",
                    onChanged: (value) {
                      // context.read<LoginBloc>().add(
                      //     LoginPasswordChanged(password: _passwordController.text));
                      // _passwordController.text = value;
                    },
                    controller: _currentPassword,
                  ),
                  RoundedPassword(
                    hintText: "Mật khẩu mới",
                    icon: Icons.lock_reset,
                    onChanged: (value) {
                      // context.read<LoginBloc>().add(
                      //     LoginPasswordChanged(password: _passwordController.text));
                      // _passwordController.text = value;
                    },
                    controller: _newPassword,
                  ),
                  RoundedPassword(
                    hintText: "Xác nhận mật khẩu",
                    icon: Icons.lock_reset,
                    onChanged: (value) {
                      // context.read<LoginBloc>().add(
                      //     LoginPasswordChanged(password: _passwordController.text));
                      // _passwordController.text = value;
                    },
                    controller: _confirmPassword,
                  ),
                  RoundedButton(
                    text: "Đổi mật khẩu",
                    press: () {
                      print(Profile.phoneNumber);
                      context.read<ChangePasswordBloc>().add(
                            ChangePasswordSubmitted(
                                userLogin: Profile.phoneNumber ?? "",
                                currentPassword: _currentPassword.text,
                                newPassword: _newPassword.text,
                                confirmPassword: _confirmPassword.text),
                          );
                    },
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, Color color) {
  final snackBar = SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: color);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
