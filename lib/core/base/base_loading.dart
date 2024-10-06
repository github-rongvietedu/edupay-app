import 'package:flutter/material.dart';

class BaseLoading extends StatelessWidget {
  const BaseLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
