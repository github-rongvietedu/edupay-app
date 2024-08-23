import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'constants.dart';

class Utils {
  static bool isFalse = false;
  static String message = "";
}

final LoadingDialog loadingDialog = LoadingDialog._internal();

int maximumSize = 2000000;
DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

/// Find last date of the week which contains provided date.
DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
}

class LoadingDialog {
  LoadingDialog._internal();

  Future<T> showLoadingPopup<T>(
    BuildContext context,
    Future<T> future, {
    String? loadingText,
    Widget? dialogState,
  }) async {
    late BuildContext popupContext;
    final dialog = dialogState ??
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: const CircularProgressIndicator(
                  color: kPrimaryColor,
                ))
              ]),
        ); // _buildLoadingDialog(context, loadingText);
    if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          popupContext = context;
          return dialog;
        },
      );
    }
    try {
      return await future;
    } catch (e) {
      rethrow;
    } finally {
      Navigator.of(popupContext, rootNavigator: true).pop();
    }
  }
}
