import 'package:flutter/material.dart';
import 'package:foda/themes/app_theme.dart';

enum ButtonState { idle, loading, disabled }

class FodaButton extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? leadingIcon;
  final List<Color>? gradiant;
  final Function()? onTap;

  const FodaButton({
    Key? key,
    required this.title,
    this.titleStyle,
    this.state = ButtonState.idle,
    this.leadingIcon,
    this.gradiant,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FodaButton> createState() => _FodaButtonState();
}

class _FodaButtonState extends State<FodaButton> {
  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.gradiant ?? [AppTheme.red, AppTheme.darkBlue];
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: AppTheme.buttonHeight,
        decoration: BoxDecoration(
            color: defaultColor.length < 2 ? defaultColor.first : null,
            borderRadius: BorderRadius.circular(99),
            gradient: defaultColor.length > 1
                ? LinearGradient(
                    colors: defaultColor,
                  )
                : null),
        child: widget.state == ButtonState.loading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leadingIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: AppTheme.elementSpacing * 0.25),
                      child: widget.leadingIcon,
                    ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.button,
                  ),
                ],
              ),
      ),
    );
  }
}
