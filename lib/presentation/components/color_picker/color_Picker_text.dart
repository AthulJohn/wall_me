import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';

import '../../../logic/bloc/textfield/textfield_cubit.dart';
import '../../../logic/models/workshop/image_component_model.dart';
import 'color_picker.dart';

enum ColorPickerType { background, font, image }

class ColorPickerWithText extends StatelessWidget {
  ColorPickerWithText({
    super.key,
    this.colorPickerType = ColorPickerType.font,
  });
  final ColorPickerType colorPickerType;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        colorPickerType == ColorPickerType.image
            ? BlocBuilder<SinglenoteBloc, SinglenoteState>(
                builder: (context, state) {
                  return ColorIndicator(
                    color: state.currentImage == null
                        ? Colors.black
                        : state.currentImage!.overlayColor,
                    width: 24,
                    height: 30,
                    borderRadius: 4,
                    onSelectFocus: false,
                    onSelect: () {
                      colorPickerDialog(
                          state.currentImage == null
                              ? Colors.black
                              : state.currentImage!.overlayColor,
                          (Color color) {
                        BlocProvider.of<SinglenoteBloc>(context).add(
                            ChangeImageStyle(
                                (state.currentImage ?? ImageComponent())
                                    .copyWith(overlayColor: color)));
                      }, context);
                    },
                  );
                },
              )
            : BlocBuilder<TextFieldCubit, TextFieldState>(
                builder: (context, state) {
                  return ColorIndicator(
                    color: state.textComponent.fontColor,
                    width: 24,
                    height: 30,
                    borderRadius: 4,
                    onSelectFocus: false,
                    onSelect: () {
                      colorPickerDialog(state.textComponent.fontColor,
                          (Color color) {
                        BlocProvider.of<TextFieldCubit>(context)
                            .changeColor(color);
                      }, context);
                    },
                  );
                },
              ),
        SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 30,
            width: 120,
            child: colorPickerType == ColorPickerType.image
                ? BlocConsumer<SinglenoteBloc, SinglenoteState>(
                    listener: (context, state) {
                      _controller.clear();
                    },
                    listenWhen: (previous, current) {
                      return previous.currentImageIndex !=
                          current.currentImageIndex;
                    },
                    builder: (context, state) => TextField(
                          controller: _controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-fA-F0-9]'))
                          ],
                          maxLength: 6,
                          onChanged: (String value) {
                            if (value.length == 6 &&
                                value.contains(RegExp(r'[a-fA-F0-9]{6}'))) {
                              BlocProvider.of<SinglenoteBloc>(context).add(
                                  ChangeImageColor(Color(
                                      int.parse(value, radix: 16) +
                                          0xFF000000)));
                            }
                          },
                          decoration: InputDecoration(
                            prefixText: '#',
                            counterText: '',
                            border: OutlineInputBorder(),
                            hintText: state.currentImage?.overlayColor.value
                                .toRadixString(16)
                                .substring(2),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                          ),
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                        ))
                : BlocConsumer<TextFieldCubit, TextFieldState>(
                    listener: (context, state) {
                    _controller.clear();
                  }, listenWhen: (previous, current) {
                    return previous.textComponent.textId !=
                        current.textComponent.textId;
                  }, builder: (context, state) {
                    return TextField(
                      controller: _controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-fA-F0-9]'))
                      ],
                      maxLength: 6,
                      onChanged: (String value) {
                        if (value.length == 6 &&
                            value.contains(RegExp(r'[a-fA-F0-9]{6}'))) {
                          BlocProvider.of<TextFieldCubit>(context).changeColor(
                              Color(int.parse(value, radix: 16) + 0xFF000000));
                        }
                      },
                      decoration: InputDecoration(
                        prefixText: '#',
                        counterText: '',
                        border: OutlineInputBorder(),
                        hintText: state.textComponent.fontColor.value
                            .toRadixString(16)
                            .substring(2),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    );
                  }))
      ],
    );
  }
}
