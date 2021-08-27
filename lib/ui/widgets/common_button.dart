import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final Color backgroundColor;
  final OutlinedBorder? border;

  const CommonTextButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: child,
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: border != null ? MaterialStateProperty.all(border) : null),
    );
  }
}
