import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'package:wall_me/constants/text_styles.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/logic/bloc/textfield/textfield_cubit.dart';

import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../../color_picker/color_Picker_text.dart';
import '../../color_picker/color_picker.dart';
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                    child: Text('Font Color')),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ColorPickerWithText(),
                ),
                const SizedBox(height: 10),
                const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text("Font Size")),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizeSlider(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text("Text Alignment")),
          const SizedBox(height: 5),
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

class SizeSlider extends StatelessWidget {
  SizeSlider({
    super.key,
  });
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
              width: 36,
              height: 30,
              child: TextField(
                controller: _controller,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  double size =
                      double.tryParse(value) ?? state.textComponent.fontSize;
                  BlocProvider.of<TextFieldCubit>(context).changeSize(
                    size > 100
                        ? 100
                        : size < 20
                            ? 20
                            : size,
                  );
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: state.textComponent.fontSize.toString(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Slider(
              value: state.textComponent.fontSize,
              thumbColor: CustomColor.tertiaryColor,
              activeColor: CustomColor.tertiaryColor,
              inactiveColor: Colors.grey,
              autofocus: true,
              onChanged: (value) {
                BlocProvider.of<TextFieldCubit>(context).changeSize(value);
                _controller =
                    TextEditingController(text: value.toStringAsFixed(0));
              },
              min: 20,
              max: 100,
            ),
          ],
        );
      },
    );
  }
}
