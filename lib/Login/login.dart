import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SplashScreen(),

      // BlocProvider(
      //   create: (_) => LoginBloc(context),
      //   child: const SplashScreen(),
      // )
    );
  }
}
