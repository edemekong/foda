import 'package:flutter/material.dart';

class FodaTextfield extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  const FodaTextfield({
    Key? key,
    required this.title,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
