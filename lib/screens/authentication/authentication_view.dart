import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foda/components/amaoba_paint.dart';
import 'package:foda/components/app_scaffold.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/constant/image_path.dart';
import 'package:foda/screens/onboard/onboard_view.dart';
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

class SignUpView extends StatelessWidget {
  const SignUpView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AuthHeader("Sign Up"),
            const SizedBox(height: AppTheme.cardPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
              child: FodaButton(
                title: "Sign In With Google",
                gradiant: const [
                  AppTheme.orange,
                  AppTheme.red,
                ],
                leadingIcon: const Icon(
                  Icons.facebook,
                  color: AppTheme.white,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Text(
              "Or with Email",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppTheme.grey),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            const FodaTextfield(
              title: "Your Name",
            ),
            const SizedBox(height: AppTheme.elementSpacing),
            const FodaTextfield(
              title: "Your Email",
            ),
            const SizedBox(height: AppTheme.elementSpacing),
            const FodaTextfield(
              title: "Password",
            ),
            const SizedBox(height: AppTheme.cardPadding),
            FodaButton(
              title: "Sign Up",
              onTap: () {},
            ),
            const SizedBox(height: AppTheme.cardPadding * 4),
          ],
        ),
      ),
    );
  }
}

class ComeSignIn extends StatelessWidget {
  const ComeSignIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppTheme.cardPadding * 4),
          Image.asset(
            ImagePath.avatar,
            fit: BoxFit.cover,
          ),
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: AppTheme.elementSpacing),
          const AuthHeader("Flutter Fairy"),
          const SizedBox(height: AppTheme.cardPadding * 2),
          const FodaTextfield(
            title: "Password",
          ),
          const SizedBox(height: AppTheme.cardPadding),
          FodaButton(
            title: "Sign In",
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AuthHeader("Sign In"),
            const SizedBox(height: AppTheme.cardPadding),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 2),
              child: FodaButton(
                title: "Sign In With Google",
                gradiant: const [
                  AppTheme.orange,
                  AppTheme.red,
                ],
                leadingIcon: const Icon(
                  Icons.facebook,
                  color: AppTheme.white,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Text(
              "Or with Email",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppTheme.grey),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            const FodaTextfield(
              title: "Your Email",
            ),
            const SizedBox(height: AppTheme.elementSpacing),
            const FodaTextfield(
              title: "Password",
            ),
            const SizedBox(height: AppTheme.cardPadding),
            FodaButton(
              title: "Sign In",
              onTap: () {},
            ),
            const SizedBox(height: AppTheme.cardPadding * 4),
          ],
        ),
      ),
    );
  }
}

class FodaTextfield extends StatelessWidget {
  final String title;
  const FodaTextfield({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
