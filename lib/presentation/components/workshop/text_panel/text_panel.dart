import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/global_variables.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';
import 'package:wall_me/presentation/components/workshop/template_panel/template_card.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../../../../logic/models/workshop/text_component_model.dart';
import '../close_button.dart';
import 'text_align_buttons.dart';
import 'text_style_buttons.dart';

class TextEditPanel extends StatelessWidget {
  const TextEditPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: state.isTextEditOpen ? max(180, getWidth(context) * 0.25) : 0,
        child: const TextPanelBody(),
      );
    });
  }
}

class TextPanelBody extends StatelessWidget {
  const TextPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Text Options"),
          ),
          BlocBuilder<TextFieldCubit, TextFieldState>(
            builder: (context, state) {
              return FittedBox(
                fit: BoxFit.scaleDown,
                child: DropdownButton(
                    value: state.textComponent.fontFamily,
                    items: [
                      for (String fontName in fonts)
                        DropdownMenuItem(
                          value: fontName,
                          child: Text(fontName),
                        ),
                    ],
                    onChanged: (val) {
                      BlocProvider.of<TextFieldCubit>(context)
                          .changeFont(val ?? 'Poppins');
                    }),
              );
            },
          ),
          Row(
            children: const [
              TextBoldButton(),
              SizedBox(
                width: 5,
              ),
              TextItalicsButton(),
              SizedBox(
                width: 5,
              ),
              TextUnderlineButton(),
            ],
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: BlocBuilder<TextFieldCubit, TextFieldState>(
              builder: (context, state) {
                return SizedBox(
                  // width: 150,
                  height: 400,
                  child: BlockPicker(
                    pickerColor: state.textComponent.fontColor,
                    onColorChanged: (color) {
                      BlocProvider.of<TextFieldCubit>(context)
                          .changeColor(color);
                    },
                    useInShowDialog: false,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const FittedBox(
              fit: BoxFit.scaleDown, child: Text("Overlay Opacity")),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: BlocBuilder<TextFieldCubit, TextFieldState>(
              builder: (context, state) {
                return Slider(
                  value: state.textComponent.fontSize,
                  onChanged: (value) {
                    BlocProvider.of<TextFieldCubit>(context).changeSize(value);
                  },
                  min: 10,
                  max: 50,
                );
              },
            ),
          ),
          Row(
            children: const [
              TextAlignLeftButton(),
              SizedBox(
                width: 5,
              ),
              TextAlignCenterButton(),
              SizedBox(
                width: 5,
              ),
              TextAlignRightButton(),
            ],
          ),
        ],
      ),
    );
  }
}
