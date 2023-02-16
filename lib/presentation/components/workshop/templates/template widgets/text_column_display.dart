import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/text_field.dart';

import '../../../../../global_functions.dart';
import '../../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../../logic/models/workshop/text_component_model.dart';

class TextColumnDisplay extends StatelessWidget {
  const TextColumnDisplay(
      {super.key, required this.textComponents, required this.templateId});
  final List<TextComponent> textComponents;
  final int templateId;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (TextComponent tc in textComponents)
          Padding(
            padding: EdgeInsets.all(tc.fontSize / 2),
            child:
                LayoutBuilder(builder: (context, BoxConstraints constraints) {
              return Text(
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
              );
            }),
          ),
      ]),
    );
  }
}
