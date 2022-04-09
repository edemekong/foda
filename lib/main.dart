import 'package:flutter/material.dart';
import 'package:foda/themes/app_theme.dart';

void main() {
  runApp(const FodaApp());
}

class FodaApp extends StatelessWidget {
  const FodaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Foda',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
