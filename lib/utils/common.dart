import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foda/themes/app_theme.dart';

void fodaPrint(dynamic value) {
  debugPrint(value.toString());
}

int timeNow() {
  return DateTime.now().millisecondsSinceEpoch;
}

void showCustomToast(String message, {Color? color, Color? textColor, bool isError = false}) => Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? AppTheme.red : (color ?? Colors.black),
      textColor: textColor ?? Colors.white,
      fontSize: 16,
    );
