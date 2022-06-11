import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foda/components/amaoba_paint.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/constant/image_path.dart';
import 'package:foda/screens/authentication/pages/come_back.dart';
import 'package:foda/screens/authentication/pages/sign_in.dart';
import 'package:foda/screens/authentication/pages/sign_up.dart';
import 'package:foda/themes/app_theme.dart';

enum AuthenticationViewState { signIn, signUp, comeBack }

class AuthenticationView extends StatelessWidget {
  final AuthenticationViewState viewState;

  const AuthenticationView({Key? key, required this.viewState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          if (viewState == AuthenticationViewState.comeBack)
            Stack(
              children: const [
                Positioned(
                  left: -110,
                  child: AmaobaPaint(
                    color: AppTheme.darkBlueLight,
                  ),
                ),
                Positioned(
                  left: -10,
                  top: -50,
                  child: AmaobaPaint(
                    color: AppTheme.darkBlue,
                  ),
                ),
              ],
            ),
          if (viewState == AuthenticationViewState.signIn || viewState == AuthenticationViewState.signUp)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: const AmaobaPaint(
                color: AppTheme.darkBlueLight,
              ),
            ),
          if (viewState == AuthenticationViewState.signIn || viewState == AuthenticationViewState.signUp)
            Positioned(
              right: -60,
              top: -10,
              child: Image.asset(
                viewState == AuthenticationViewState.signUp ? ImagePath.fries : ImagePath.salad,
                height: 300,
              ),
            ),
          Builder(builder: (context) {
            if (viewState == AuthenticationViewState.signUp) {
              return const SignUpView();
            }
            if (viewState == AuthenticationViewState.signIn) {
              return const SignInView();
            } else {
              return const ComeSignIn();
            }
          }),
        ],
      ),
    );
  }
}
