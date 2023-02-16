import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

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
    TextEditingController tec = TextEditingController(text: initText);
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return TextField(
                    controller: tec,
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
                        hintStyle: const TextStyle(color: Colors.black26),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.black12))),
                    onChanged: (value) {
                      BlocProvider.of<TextFieldCubit>(context)
                          .changeText(value);
                    },
                    onTap: () {
                      BlocProvider.of<WorkshopUiCubit>(context)
                          .activateTextPanel();
                    },
                  );
                }),
              ),
              if (state.textComponent.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    BlocProvider.of<NotesBloc>(context)
                        .add(ChangeText(state.textComponent));
                    BlocProvider.of<TextFieldCubit>(context).changeText('');

                    tec.clear();
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
