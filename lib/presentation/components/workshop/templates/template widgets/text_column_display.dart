import 'package:flutter/material.dart';

import '../../../../../global_functions.dart';
import '../../../../../logic/models/workshop/text_component_model.dart';

class TextColumnDisplay extends StatelessWidget {
  const TextColumnDisplay(
      {super.key,
      required this.textComponents,
      required this.templateId,
      this.alignment = Alignment.center});
  final List<TextComponent> textComponents;
  final Alignment alignment;
  final int templateId;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      alignment: alignment,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (TextComponent tc in textComponents)
          LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Padding(
              padding: EdgeInsets.all(
                  getFontSize(tc.fontSize, constraints.maxWidth, templateId) /
                      2),
              child: Text(
                tc.text,
                style: TextStyle(
                    fontSize: getFontSize(
                        tc.fontSize, constraints.maxWidth, templateId),
                    fontWeight: tc.isBold ? FontWeight.bold : FontWeight.normal,
                    color: tc.fontColor,
                    fontFamily: tc.fontFamily,
                    fontStyle:
                        tc.isItalic ? FontStyle.italic : FontStyle.normal,
                    decoration: tc.isUnderlined
                        ? TextDecoration.underline
                        : TextDecoration.none),
                textAlign: tc.textAlign,
              ),
            );
          }),
      ]),
    );
  }
}
