import 'package:flutter/material.dart';
import 'package:foda/themes/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  const AppScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppTheme.size(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          radius: 1.5,
          colors: [
            AppTheme.blackLight,
            AppTheme.black,
          ],
        )),
        child: body,
      ),
    );
  }
}
