import 'package:flutter/material.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';

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
    return imageComponent == null
        ? Container()
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(
                    image: NetworkImage(imageComponent!.url),
                    colorFilter: ColorFilter.mode(
                        imageComponent!.overlayColor
                            .withOpacity(imageComponent!.overlayIntensity),
                        BlendMode.darken),
                    fit: imageComponent!.fit)));
  }
}
