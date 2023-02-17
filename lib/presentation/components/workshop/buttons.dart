import 'package:flutter/material.dart';
import 'package:wall_me/color_pallette.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.icon,
    this.text,
    required this.onPressed,
  });
  final String? text;
  final IconData? icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(CustomColor.tertiaryColor),
          shape: MaterialStateProperty.all(const StadiumBorder())),
      onPressed: onPressed,
      child: Row(children: [
        if (text != null) Text(text!),
        if (icon != null) Icon(icon)
      ]),
    );
  }
}
