import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? press;
  final Color color, textColor;
  final bool enable;
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = kPrimaryColor,
      this.textColor = Colors.white,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: enable == true ? color : Colors.grey,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: flatButtonStyle,
          onPressed: enable == true ? press : null,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
