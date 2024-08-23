import 'package:flutter/material.dart';

import '../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(29),
          border: Border.all(width: 2, color: kPrimaryColor)),
      child: child,
    );
  }
}
