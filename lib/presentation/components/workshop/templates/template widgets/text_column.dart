import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          case TextStatus.empty:
            return const Center(child: TextEnteringField());
          case TextStatus.success:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (TextComponent tc in textComponents)
                  textComponents.indexOf(tc) == state.currentTextIndex
                      ? TextEnteringField(initText: tc.text)
                      : Padding(
                          padding: EdgeInsets.all(tc.fontSize / 2),
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<NotesBloc>(context).add(
                                  ChangeTextSelection(
                                      0, textComponents.indexOf(tc)));
                            },
                            child: Text(tc.text,
                                style: TextStyle(
                                    fontSize: tc.fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: tc.fontColor)),
                          ),
                        ),
                state.currentTextIndex ==
                        state.currentNote!.textComponents.first.length
                    ? const TextEnteringField()
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
