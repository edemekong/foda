import 'package:flutter/material.dart';

void fodaPrint(dynamic value) {
  debugPrint(value.toString());
}

int timeNow() {
  return DateTime.now().millisecondsSinceEpoch;
}
