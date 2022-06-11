import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/screens/onboard/onboard_view.dart';
import 'package:foda/themes/app_theme.dart';

import '../../../components/textfield.dart';

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
