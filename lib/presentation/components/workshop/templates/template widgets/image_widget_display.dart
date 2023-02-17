import 'package:flutter/material.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';

class ImageDisplay extends StatelessWidget {
  final ImageComponent? imageComponent;
  final double borderRadius;
  final int imageIndex;
  const ImageDisplay(
      {super.key,
      required this.imageIndex,
      this.imageComponent,
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return imageComponent == null
        ? Container()
        : Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageComponent!.url,
                fit: imageComponent!.fit,
              ),
              Container(
                color: imageComponent!.overlayColor
                    .withOpacity(imageComponent!.overlayIntensity),
              )
            ],
          );
  }
}
