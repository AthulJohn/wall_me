import 'package:flutter/material.dart';
import 'package:wall_me/constants/color_pallette.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.icon,
    this.text,
    this.hasPadding = false,
    required this.onPressed,
  });
  final String? text;
  final IconData? icon;
  final bool hasPadding;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(CustomColor.tertiaryColor),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        padding: hasPadding
            ? const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 30, vertical: 20))
            : null,
      ),
      onPressed: onPressed,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (text != null) Text(text!),
        if (icon != null) Icon(icon)
      ]),
    );
  }
}

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(CustomColor.tertiaryColor),
          shape: MaterialStateProperty.all(const CircleBorder()),
          padding: MaterialStatePropertyAll(EdgeInsets.all(5))),
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
