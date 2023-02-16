import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/global_functions.dart';
import 'package:wall_me/global_variables.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/text_field.dart';

import '../../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../../logic/models/workshop/text_component_model.dart';

class TextColumn extends StatelessWidget {
  const TextColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      child: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
        List<TextComponent> textComponents =
            state.currentNote!.textComponents.first;
        switch (state.textStatus) {
          case TextStatus.success:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (TextComponent tc in textComponents)
                  textComponents.indexOf(tc) == state.currentTextIndex
                      ? TextEnteringField(
                          initText: tc.text,
                          templateId: state.currentNote!.templateId,
                        )
                      : Padding(
                          padding: EdgeInsets.all(tc.fontSize / 2),
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<NotesBloc>(context).add(
                                  ChangeTextSelection(
                                      0, textComponents.indexOf(tc)));
                              BlocProvider.of<TextFieldCubit>(context)
                                  .setTextComponent(tc);
                            },
                            child: LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Text(
                                tc.text,
                                style: TextStyle(
                                    fontSize: getFontSize(
                                        tc.fontSize,
                                        constraints.maxWidth,
                                        state.currentNote!.templateId),
                                    fontWeight: tc.isBold
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: tc.fontColor,
                                    fontFamily: tc.fontFamily,
                                    fontStyle: tc.isItalic
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                    decoration: tc.isUnderlined
                                        ? TextDecoration.underline
                                        : TextDecoration.none),
                                textAlign: tc.textAlign,
                              );
                            }),
                          ),
                        ),
                state.currentTextIndex ==
                        state.currentNote!.textComponents.first.length
                    ? TextEnteringField(
                        templateId: state.currentNote!.templateId,
                      )
                    : InkWell(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 20,
                        ),
                        onTap: () {
                          BlocProvider.of<NotesBloc>(context).add(
                              ChangeTextSelection(
                                  0,
                                  state.currentNote!.textComponents.first
                                      .length));
                          BlocProvider.of<TextFieldCubit>(context)
                              .setTextComponent(
                                  BlocProvider.of<NotesBloc>(context)
                                          .state
                                          .currentText ??
                                      TextComponent());
                          BlocProvider.of<WorkshopUiCubit>(context)
                              .activateTextPanel();
                        },
                      )
              ],
            );
          case TextStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case TextStatus.error:
            return const Center(child: Text('Error'));
        }
      }),
    );
  }
}
