import 'package:flutter/material.dart';

class FodaTextfield extends StatelessWidget {
  final String title;
  const FodaTextfield({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
