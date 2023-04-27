import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';

import '../../../../../logic/models/workshop/image_component_model.dart';

DecorationImage getDecorationImage(
    BuildContext context, ImageComponent imageComponent,
    {bool isEditable = false}) {
  return DecorationImage(
      image: NetworkImage(imageComponent.url),
      colorFilter: ColorFilter.mode(
          imageComponent.overlayColor
              .withOpacity(imageComponent.overlayIntensity),
          BlendMode.hardLight),
      fit: imageComponent.fit,
      onError: (Object onject, StackTrace? stacktrace) {
        if (isEditable) {
          BlocProvider.of<SinglenoteBloc>(context)
              .add(SetImageInvalid(imageComponent.url));
        }
      });
}
