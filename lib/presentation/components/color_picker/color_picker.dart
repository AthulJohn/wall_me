import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/singlenote/singlenote_bloc.dart';

Future<bool> colorPickerDialog(
    Color color, Function(Color) onChanged, context) async {
  Color changedColor = color;
  return ColorPicker(
    // Use the dialogPickerColor as start color.
    color: changedColor,
    onColorChanged: (value) {
      changedColor = value;
    },
    // Update the dialogPickerColor using the callback.
    onColorChangeEnd: onChanged,
    width: 40,
    height: 40,
    borderRadius: 4,
    spacing: 5,
    runSpacing: 5,
    wheelDiameter: 155,
    heading: Text(
      'Select color',
    ),
    subheading: Text(
      'Select color shade',
    ),
    wheelSubheading: Text(
      'Selected color and its shades',
    ),
    showMaterialName: true,
    showColorName: true,
    showColorCode: true,
    copyPasteBehavior: const ColorPickerCopyPasteBehavior(
      longPressMenu: true,
    ),
    // materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
    // colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
    // colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    },
    // customColorSwatchesAndNames: colorsNameMap,
  ).showPickerDialog(
    context,
    // New in version 3.0.0 custom transitions support.
    transitionBuilder: (BuildContext context, Animation<double> a1,
        Animation<double> a2, Widget widget) {
      final double curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: a1.value,
          child: widget,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
    constraints:
        const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
  );
}
