import 'package:flutter/material.dart';

class TextComponent {
  String text;
  String fontFamily;
  double fontSize;
  Color fontColor;
  bool isBold, isUnderlined, isItalic;
  TextAlign textAlign;

  TextComponent({
    this.text = "Sample Text",
    this.fontFamily = "Poppins",
    this.fontSize = 20,
    this.fontColor = Colors.black,
    this.isBold = false,
    this.isUnderlined = false,
    this.isItalic = false,
    this.textAlign = TextAlign.center,
  });
}
