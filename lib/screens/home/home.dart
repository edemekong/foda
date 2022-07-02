import 'package:flutter/material.dart';

import '../../components/app_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
