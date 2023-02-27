import 'package:flutter/material.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import 'image_component_model.dart';

class SingleNote {
  List<List<TextComponent>> textComponents;
  List<ImageComponent> imageComponents;
  Color? backgroundColor;
  int templateId = 1;
  int noteid;

  SingleNote(
      {this.noteid = 0,
      this.textComponents = const [[]],
      this.imageComponents = const [],
      this.templateId = 11,
      this.backgroundColor = Colors.white});

  SingleNote copyWith({
    List<List<TextComponent>>? textComponents,
    List<ImageComponent>? imageComponents,
    Color? backgroundColor,
    int? templateId,
    int? noteid,
  }) {
    return SingleNote(
      textComponents: textComponents ?? this.textComponents,
      imageComponents: imageComponents ?? this.imageComponents,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      templateId: templateId ?? this.templateId,
      noteid: noteid ?? this.noteid,
    );
  }

  void addImage(String imagePath, String mimeType, int index) {
    if (imageComponents.isEmpty) {
      imageComponents = [ImageComponent(url: '')];
    }
    while (imageComponents.length <= index) {
      imageComponents.add(ImageComponent(url: ''));
    }
    imageComponents[index] =
        (imageComponents[index].copyWith(url: imagePath, mimeType: mimeType));
  }
}
