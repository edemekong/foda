import 'package:flutter/material.dart';
import 'package:foda/screens/authentication/authentication_view.dart';
import 'package:foda/screens/onboard/onboard_view.dart';
import 'package:foda/themes/app_theme.dart';

void main() {
  runApp(const FodaApp());
}

class FodaApp extends StatelessWidget {
  const FodaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const AuthenticationView(
        viewState: AuthenticationViewState.signUp,
      ),
    );
  }
}
