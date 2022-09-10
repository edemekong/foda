import 'package:flutter/material.dart';
import 'package:foda/themes/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget body;
  final Color? backgroundColor;
  const AppScaffold({
    Key? key,
    required this.body,
    this.appbar,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppTheme.size(context);
    return Scaffold(
      appBar: appbar,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            color: backgroundColor,
            gradient: backgroundColor != null
                ? null
                : const RadialGradient(
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
