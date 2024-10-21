import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final int maxLine;
  Function(String)? onTextChanged;
  Function()? onRightIconPressed; // Callback passed to widget
  final String leftIcon;
  final String rightIcon;
  double leftIconSize;
  final String hintText;
  var valueController;
  final bool readonly;
  final bool isMoney;
  final bool isNumber;
  final bool isPassword;
  final bool isPersonName;
  final Color borderColor;
  final fontsSze;
  final bool isBankName; // New field to specify if the input is for bankName
  Color leftIconColor;
  Color rightIconColor;
  Color leftIconBackgroundColor;
  Color leftIconFocusedIconColor;
  Color rightIconFocusedIconColor;
  double padding;
  Color hintTextColor;
  Color textColor;
  Color backgroundColor;
  double? borderRadius;
  double clearIconSize;
  double suffixIconSize;
  double rightIconSize;
  Color suffixIconColor;
  Color suffixIconFocusColor;
  var suffixIcon;
  Input(
      {this.isMoney = false,
        this.borderColor=Colors.transparent,
        this.maxLine=1,
        this.isPersonName = false,
        this.fontsSze = 14.0,
        this.suffixIconColor = const Color.fromRGBO(148, 163, 138, 0.9),
        this.hintTextColor = const Color.fromRGBO(148, 163, 184, 1),
        this.suffixIconFocusColor = const Color.fromRGBO(148, 163, 138, 0.9),
        this.leftIcon = '',
        required this.hintText,
        required this.valueController,
        this.readonly = false,
        this.isPassword = false,
        this.isBankName = false, // Default is false
        this.leftIconColor = Colors.grey,
        this.rightIconColor = Colors.grey,
        this.leftIconBackgroundColor = Colors.transparent,
        this.backgroundColor = Colors.white,
        this.padding = 0,
        this.isNumber = false,
        this.leftIconFocusedIconColor = Colors.grey,
        this.rightIconFocusedIconColor = Colors.grey,
        this.borderRadius = 12,
        this.textColor = Colors.black,
        this.clearIconSize = 21,
        this.suffixIconSize = 21,
        this.leftIconSize = 21,
        this.onTextChanged,
        this.onRightIconPressed,
        this.rightIcon='',
        this.rightIconSize = 21,
        this.suffixIcon});

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController _controller = TextEditingController();
  late FocusNode _focusNode;
  late ValueNotifier<bool> _isFocused;
  late bool _obscureText;

  @override
  void initState() {
    _controller.text = widget.valueController.value;
    super.initState();
    _focusNode = FocusNode();
    _isFocused = ValueNotifier<bool>(false);
    _focusNode.addListener(() {
      _isFocused.value = _focusNode.hasFocus;
    });
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _isFocused.dispose();
    super.dispose();
  }

  String _removeInvalidCharacters(String input) {
    if (widget.isBankName) {
      final validCharacters = RegExp(r'[a-zA-Z ]');
      input = input.split('').where((c) => validCharacters.hasMatch(c)).join();
      input = input.replaceAll(RegExp(r'\s+'), ' ');
    } else if (widget.isNumber || widget.isMoney) {
      final validCharacters = RegExp(r'[0-9]');
      input = input.split('').where((c) => validCharacters.hasMatch(c)).join();
    } else if (widget.isPersonName) {
      // final validCharacters = RegExp(r"[a-zA-ZÀ-ỹà-ỹ '-]");
      // input = input.split('').where((c) => validCharacters.hasMatch(c)).join();
      // input = input.replaceAll(RegExp(r'\s+'), ' '); // Replace multiple spaces with a single space
    }
    return input;
  }

  String _formatAsMoney(String input) {
    if (input.isEmpty) return '';
    final number = int.parse(input.replaceAll(',', ''));
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '', // No symbol for now; adjust as needed
      decimalDigits: 0,
    );
    return formatter.format(number);
  }
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.valueController.value;
    return TextField(
      readOnly: widget.readonly,
      onChanged: (String s) {
        int cursorPosition = _controller.selection.baseOffset;
        String filteredValue = _removeInvalidCharacters(s);

        if (widget.isMoney) {
          String originalText = _controller.text;
          filteredValue = _formatAsMoney(filteredValue);
          int newCursorPosition =
              cursorPosition + (filteredValue.length - originalText.length);
          _controller.text = filteredValue;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(
                offset: newCursorPosition.clamp(0, filteredValue.length)),
          );
        } else {
          _controller.text = filteredValue;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: cursorPosition.clamp(0, filteredValue.length)),
          );
        }
        widget.valueController.value = filteredValue;
        if (widget.onTextChanged != null) {
          widget.onTextChanged!(filteredValue);
        }
      },
      controller: _controller,
      focusNode: _focusNode,
      obscureText: _obscureText,
      keyboardType: widget.isPersonName
          ? TextInputType.text
          : (widget.isNumber || widget.isMoney)
          ? TextInputType.number
          : TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
            RegExp(r'^\s')), // Avoid leading spaces
        if (widget.isNumber)
          FilteringTextInputFormatter
              .digitsOnly, // Only allow digits if isNumber is true
      ],
      minLines: widget.maxLine,
      maxLines: null,
      decoration: InputDecoration(
        prefixIcon: ((widget.leftIcon ?? '') == '')
            ? null
            : Container(
          alignment: Alignment.centerLeft,
          width: widget.leftIconSize,
          height: widget.leftIconSize,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, child) {
              return Container(
                child: Center(
                  child: Container(
                    width: widget.leftIconSize,
                    height: widget.leftIconSize,
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      widget.leftIcon,
                      fit: BoxFit.contain,
                      color: isFocused
                          ? widget.leftIconFocusedIconColor
                          : widget.leftIconColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        suffixIcon: widget.isPassword||((widget.rightIcon??'')!='')
            ? Row(
            mainAxisSize: MainAxisSize
                .min, // Ensure the row doesn't take up more space than needed
            children: [
              ((widget.rightIcon ?? '') == '')
                  ? const SizedBox():
              GestureDetector(
                onTap: () {
                  widget.onRightIconPressed!();
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isFocused,
                  builder: (context, isFocused, child) {
                    return Container(
                      child: Center(
                        child:  Container(
                          width: widget.leftIconSize,
                          height: widget.rightIconSize,
                          padding: const EdgeInsets.all(0),
                          child: Image.asset(
                            widget.rightIcon,
                            fit: BoxFit.contain,
                            color: (isFocused??false)
                                ? widget.rightIconFocusedIconColor
                                : widget.rightIconColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              !widget.isPassword?const SizedBox():
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.text = '';
                      widget.valueController.value = '';
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.clear,
                        size: widget.clearIconSize,
                        color: const Color.fromRGBO(148, 163, 138, 0.9),
                      ))),
              !widget.isPassword?const SizedBox():
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 9),
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: widget.suffixIconSize,
                        color: _obscureText
                            ? widget.suffixIconFocusColor
                            : widget.suffixIconColor,
                      ))),
            ])
            : widget.suffixIcon ?? null,
        hintText: widget.hintText,
        hintStyle:
        TextStyle(fontSize: widget.fontsSze, color: widget.hintTextColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // When focused
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // When enabled but not focused
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // When there's an error
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // Error state when focused
        ),
        fillColor: widget.backgroundColor,
        filled: true,
        contentPadding:
        const EdgeInsets.only(top: 12.0, bottom: 12, left: 8, right: 8),
      ),
      style: TextStyle(fontSize: widget.fontsSze, color: widget.textColor),
    );
  }
}
