import 'package:flutter/material.dart';

import '../../../../../logic/models/workshop/image_component_model.dart';

DecorationImage getDecorationImage(ImageComponent imageComponent) {
  return DecorationImage(
      image: NetworkImage(imageComponent.url),
      colorFilter: ColorFilter.mode(
          imageComponent.overlayColor
              .withOpacity(imageComponent.overlayIntensity),
          BlendMode.darken),
      fit: imageComponent.fit);
}
