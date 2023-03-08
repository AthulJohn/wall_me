import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'package:wall_me/constants/text_styles.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';

import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
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
        width: state.isTextEditOpen ? max(180, getWidth(context) * 0.2) : 0,
        color: Colors.white,
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
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Text Options",
              style: CustomTextStyles.panelTitle,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100]),
            child: Column(
              children: [
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
                      return Container(
                        // width: 150,
                        width: 100,
                        height: 100,
                        child: Row(
                          children: [
                            ColorPickerInput(
                              state.textComponent.fontColor,
                              // availableColors: const [
                              //   Colors.black,
                              //   Colors.grey,
                              //   Colors.white,
                              //   Colors.red,
                              //   Colors.green,
                              //   Colors.blue,
                              //   Colors.yellow,
                              //   Colors.orange,
                              // ],
                              // itemBuilder: (color, isCurrentColor, changeColor) {
                              //   return Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(2),
                              //       color: color,
                              //       border: isCurrentColor
                              //           ? Border.all(
                              //               color: CustomColor.tertiaryColor,
                              //             )
                              //           : null,
                              //     ),
                              //     constraints: BoxConstraints.tight(Size(10, 10)),
                              //   );
                              // },
                              (color) {
                                BlocProvider.of<TextFieldCubit>(context)
                                    .changeColor(color);
                              },
                              // useInShowDialog: false,
                            ),
                          ],
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
                          BlocProvider.of<TextFieldCubit>(context)
                              .changeSize(value);
                        },
                        min: 20,
                        max: 100,
                      );
                    },
                  ),
                ),
              ],
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
