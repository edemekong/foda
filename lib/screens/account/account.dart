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
    final userRepo = locate<UserRepository>();

    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userRepo.currentUserNotifier.value!.email,
              style: Theme.of(context).textTheme.headline5,
            ),
            Center(
              child: FodaButton(
                onTap: () async {
                  await userRepo.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    authPath,
                    (route) => false,
                    arguments: AuthenticationViewState.signIn,
                  );
                },
                title: 'Logout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
