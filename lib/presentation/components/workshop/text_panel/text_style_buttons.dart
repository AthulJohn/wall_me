import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';

enum EditStyle { bold, italics, underline }

class TextEditButton extends StatelessWidget {
  const TextEditButton({super.key, required this.style});
  final EditStyle style;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        return Expanded(
          child: InkWell(
            onTap: () {
              if (style == EditStyle.bold) {
                BlocProvider.of<TextFieldCubit>(context)
                    .changeBold(!state.textComponent.isBold);
              } else if (style == EditStyle.italics) {
                BlocProvider.of<TextFieldCubit>(context)
                    .changeItalics(!state.textComponent.isItalic);
              } else {
                BlocProvider.of<TextFieldCubit>(context)
                    .changeUnderline(!state.textComponent.isUnderlined);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  color:
                      (style == EditStyle.bold && state.textComponent.isBold) ||
                              (style == EditStyle.italics &&
                                  state.textComponent.isItalic) ||
                              (style == EditStyle.underline &&
                                  state.textComponent.isUnderlined)
                          ? Colors.pink
                          : Colors.white,
                  shape: BoxShape.circle),
              child: Center(
                child: style == EditStyle.bold
                    ? Text(
                        'B',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: state.textComponent.isBold
                                ? Colors.white
                                : Colors.black),
                      )
                    : style == EditStyle.italics
                        ? Text(
                            'I',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: state.textComponent.isItalic
                                    ? Colors.white
                                    : Colors.black),
                          )
                        : Text('U',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: state.textComponent.isUnderlined
                                    ? Colors.white
                                    : Colors.black)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextBoldButton extends StatelessWidget {
  const TextBoldButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextEditButton(style: EditStyle.bold);
  }
}

class TextItalicsButton extends StatelessWidget {
  const TextItalicsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextEditButton(style: EditStyle.italics);
  }
}

class TextUnderlineButton extends StatelessWidget {
  const TextUnderlineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextEditButton(
      style: EditStyle.underline,
    );
  }
}
