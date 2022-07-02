import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/constant/route_name.dart';
import 'package:foda/repositories/user_repository.dart';
import 'package:foda/screens/authentication/authentication_view.dart';
import 'package:foda/services/get_it.dart';

import '../../components/app_scaffold.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: FodaButton(
            onTap: () async {
              await locate<UserRepository>().logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                authPath,
                (route) => false,
                arguments: AuthenticationViewState.signIn,
              );
            },
            title: 'Logout',
          ),
        ),
      ),
    );
  }
}
