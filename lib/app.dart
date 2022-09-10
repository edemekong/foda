import 'package:flutter/material.dart';
import 'package:foda/screens/authentication/authentication_state.dart';
import 'package:foda/screens/cart/cart_state.dart';
import 'package:foda/states/overview_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:foda/wrapper.dart';
import 'package:provider/provider.dart';

class FodaApp extends StatelessWidget {
  const FodaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ChangeNotifierProvider(create: (_) => OverviewState()),
        ChangeNotifierProvider(
          create: (_) => CartState(),
          lazy: true,
        )
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const Wrapper(),
      ),
    );
  }
}
