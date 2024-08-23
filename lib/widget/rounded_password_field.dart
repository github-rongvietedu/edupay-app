import 'package:flutter/material.dart';

import '../constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    required this.hintText,
    this.icon = Icons.lock,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isHidden,
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            hintText: widget.hintText,
            icon: Icon(widget.icon, color: kPrimaryColor),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isHidden = !_isHidden;
                });
              },
              icon: !_isHidden
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              color: kPrimaryColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
