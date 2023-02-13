import 'package:flutter/material.dart';
import 'package:wall_me/models/workshop/text_component_model.dart';

import 'image_component_model.dart';

class SingleNote {
  List<List<TextComponent>> textComponents;
  List<ImageComponent> imageComponents;
  Color? backgroundColor;
  int templateId = 1;
  int noteid;

  SingleNote(
      {this.noteid = 0,
      this.textComponents = const [],
      this.imageComponents = const []});
}
