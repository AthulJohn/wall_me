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
    this.text = "",
    this.fontFamily = "Poppins",
    this.fontSize = 40,
    this.fontColor = Colors.black,
    this.isBold = false,
    this.isUnderlined = false,
    this.isItalic = false,
    this.textAlign = TextAlign.center,
    this.textId = 0,
  });

  TextComponent copyWith(
      {String? text,
      int? textId,
      bool? isBold,
      bool? isItalic,
      bool? isUnderlined,
      Color? fontColor,
      double? fontSize,
      String? fontFamily,
      TextAlign? textAlign}) {
    return TextComponent(
      text: text ?? this.text,
      textId: textId ?? this.textId,
      isBold: isBold ?? this.isBold,
      isItalic: isItalic ?? this.isItalic,
      isUnderlined: isUnderlined ?? this.isUnderlined,
      fontColor: fontColor ?? this.fontColor,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      textAlign: textAlign ?? this.textAlign,
    );
  }
}
