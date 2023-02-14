import 'package:flutter/material.dart';

class TextComponent {
  final String text;
  final String fontFamily;
  final double fontSize;
  final Color fontColor;
  final bool isBold, isUnderlined, isItalic;
  final TextAlign textAlign;
  final int textId;

  TextComponent({
    this.text = "Sample Text",
    this.fontFamily = "Poppins",
    this.fontSize = 20,
    this.fontColor = Colors.black,
    this.isBold = false,
    this.isUnderlined = false,
    this.isItalic = false,
    this.textAlign = TextAlign.center,
    this.textId = 0,
  });
}
