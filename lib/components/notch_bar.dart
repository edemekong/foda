import 'package:flutter/material.dart';
import 'package:foda/themes/app_theme.dart';

class NotchBar extends StatelessWidget {
  const NotchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 50,
      color: AppTheme.darkBlue,
    );
  }
}
