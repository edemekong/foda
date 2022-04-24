import 'package:flutter/material.dart';
import 'package:foda/constant/route_name.dart';
import 'package:foda/services/navigation_service.dart';
import 'package:foda/themes/app_theme.dart';

class FodaApp extends StatelessWidget {
  const FodaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: NavigationService.intance.navigatorKey,
        onGenerateRoute: NavigationService.intance.onGeneratedRoute,
        initialRoute: welcomePath,
      ),
    );
  }
}
