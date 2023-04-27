import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/text_field.dart';

import '../../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../../logic/models/workshop/text_component_model.dart';

class TextColumn extends StatelessWidget {
  const TextColumn(
      {super.key, this.textColumnindex = 0, this.alignment = Alignment.center});
  final int textColumnindex;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      alignment: alignment,
      child: BlocBuilder<SinglenoteBloc, SinglenoteState>(
          builder: (context, state) {
        List<TextComponent> textComponents =
            state.note.textComponents.length > textColumnindex
                ? state.note.textComponents[textColumnindex]
                : [];
        switch (state.textStatus) {
          case LoadingStatus.success:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (TextComponent tc in textComponents)
                  textComponents.indexOf(tc) == state.currentTextIndex &&
                          textColumnindex == state.currentTextCollectionIndex
                      ? TextEnteringField(
                          initText: tc.text,
                          templateId: state.note.templateId,
                        )
                      : InkWell(
                          onTap: () {
                            BlocProvider.of<SinglenoteBloc>(context).add(
                                ChangeTextSelection(textColumnindex,
                                    textComponents.indexOf(tc)));
                            BlocProvider.of<TextFieldCubit>(context)
                                .setTextComponent(tc);
                            BlocProvider.of<WorkshopUiCubit>(context)
                                .activateTextPanel();
                          },
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Padding(
                              padding: EdgeInsets.all(getFontSize(tc.fontSize,
                                  constraints.maxWidth, state.note.templateId)),
                              child: Text(
                                tc.text,
                                style: TextStyle(
                                    fontSize: getFontSize(
                                        tc.fontSize,
                                        constraints.maxWidth,
                                        state.note.templateId),
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
                              ),
                            );
                          }),
                        ), // Here text column 2 makes index problems. Fix it either using bloc, or directly.

                if (textComponents.length < textLimitPerNote)
                  state.currentTextIndex == textComponents.length &&
                          textColumnindex == state.currentTextCollectionIndex
                      ? TextEnteringField(
                          templateId: state.note.templateId,
                        )
                      : InkWell(
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: const Text(
                                ' Click to add New Text ',
                                style: TextStyle(color: Colors.black26),
                              ),
                            );
                          }),
                          onTap: () {
                            BlocProvider.of<SinglenoteBloc>(context).add(
                                ChangeTextSelection(
                                    textColumnindex, textComponents.length));
                            BlocProvider.of<TextFieldCubit>(context)
                                .setTextComponent(
                                    BlocProvider.of<SinglenoteBloc>(context)
                                            .state
                                            .currentText ??
                                        TextComponent(
                                            textId:
                                                BlocProvider.of<SinglenoteBloc>(
                                                        context)
                                                    .state
                                                    .currentTextIndex));
                            BlocProvider.of<WorkshopUiCubit>(context)
                                .activateTextPanel();
                          },
                        )
              ],
            );

          case LoadingStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadingStatus.error:
          default:
            return const Center(child: Text('Error'));
        }
      }),
    );
  }
}
