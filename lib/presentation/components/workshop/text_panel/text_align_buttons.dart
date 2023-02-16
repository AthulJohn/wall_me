import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/models/workshop/text_component_model.dart';

class TextAlignButton extends StatelessWidget {
  const TextAlignButton({super.key, required this.align});
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        return Expanded(
            child: InkWell(
          onTap: () {
            BlocProvider.of<TextFieldCubit>(context).changeAlignment(align);
          },
          child: Container(
            decoration: BoxDecoration(
                color: (align == state.textComponent.textAlign)
                    ? Colors.pink
                    : Colors.white,
                shape: BoxShape.circle),
            child: Center(
              child: Icon(
                align == TextAlign.left
                    ? Icons.format_align_left_rounded
                    : align == TextAlign.center
                        ? Icons.format_align_center_rounded
                        : Icons.format_align_right_rounded,
                color: align == state.textComponent.textAlign
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ));
      },
    );
  }
}

class TextAlignLeftButton extends StatelessWidget {
  const TextAlignLeftButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextAlignButton(align: TextAlign.left);
  }
}

class TextAlignCenterButton extends StatelessWidget {
  const TextAlignCenterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextAlignButton(align: TextAlign.center);
  }
}

class TextAlignRightButton extends StatelessWidget {
  const TextAlignRightButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextAlignButton(
      align: TextAlign.right,
    );
  }
}
