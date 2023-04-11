import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';
import 'package:wall_me/presentation/components/workshop/buttons.dart';

import '../../../../../global_functions.dart';
import '../../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../../logic/bloc/textfield/textfield_cubit.dart';
import '../../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';

class TextEnteringField extends StatelessWidget {
  const TextEnteringField(
      {super.key, this.initText = "", this.templateId = 11});
  final String initText;
  final int templateId;

  @override
  Widget build(BuildContext context) {
    TextEditingController tec = TextEditingController();

    if (BlocProvider.of<TextFieldCubit>(context, listen: false)
            .state
            .textComponent
            .text
            .isNotEmpty &&
        initText.isEmpty) {
      tec = TextEditingController(
          text: BlocProvider.of<TextFieldCubit>(context, listen: false)
              .state
              .textComponent
              .text);
    } else {
      tec = TextEditingController(text: initText);
    }
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return
              // SizedBox(
              //   height:  getFontSize(50,
              //                   constraints.maxWidth, templateId),
              //   child:
              Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tec,
                  maxLines: 6,
                  minLines: 1,

                  // maxLength:
                  //     (200000 / (pow(state.textComponent.fontSize, 2))).round(),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      fontSize: getFontSize(state.textComponent.fontSize,
                          constraints.maxWidth, templateId),
                      fontWeight: state.textComponent.isBold
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: state.textComponent.fontColor,
                      fontFamily: state.textComponent.fontFamily,
                      fontStyle: state.textComponent.isItalic
                          ? FontStyle.italic
                          : FontStyle.normal,
                      decoration: state.textComponent.isUnderlined
                          ? TextDecoration.underline
                          : TextDecoration.none),
                  textAlign: state.textComponent.textAlign,
                  decoration: InputDecoration(
                      hintText: 'Enter some text',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      // fillColor: Colors.white,
                      // filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.blue)),
                      contentPadding: const EdgeInsets.all(5),
                      isDense: true),
                  onChanged: (value) {
                    BlocProvider.of<TextFieldCubit>(context).changeText(value);
                  },
                  onTap: () {
                    BlocProvider.of<WorkshopUiCubit>(context)
                        .activateTextPanel();
                  },
                ),
              ),
              SizedBox(width: 10),
              if (state.textComponent.text.isNotEmpty)
                CustomCircleButton(
                  icon: Icons.check,
                  onPressed: () {
                    BlocProvider.of<SinglenoteBloc>(context)
                        .add(ChangeText(state.textComponent));
                    BlocProvider.of<TextFieldCubit>(context)
                        .setTextComponent(TextComponent(
                      text: "",
                      textId: state.textComponent.textId + 1,
                    ));

                    tec.clear();
                  },
                ),
            ],
            // ),
          );
        });
      },
    );
  }
}
