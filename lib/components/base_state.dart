import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
