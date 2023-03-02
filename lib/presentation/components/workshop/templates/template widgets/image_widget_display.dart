import 'package:flutter/material.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/decoration_image_component.dart';

class ImageDisplay extends StatelessWidget {
  final ImageComponent? imageComponent;
  final double borderRadius;
  // final int imageIndex;
  const ImageDisplay(
      {super.key,
      // required this.imageIndex,
      this.imageComponent,
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return imageComponent == null || imageComponent!.url.isEmpty
        ? Container()
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: getDecorationImage(imageComponent!)));
  }
}
