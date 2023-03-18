import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';

import '../../../../../constants/color_pallette.dart';
import '../../../../../logic/bloc/notes/notes_bloc.dart';
import 'image_widget_display.dart';

class ImageWidget extends StatelessWidget {
  final ImageComponent? imageComponent;
  final double borderRadius;
  final int imageIndex;
  const ImageWidget(
      {super.key,
      required this.imageIndex,
      this.imageComponent,
      this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return imageComponent == null || imageComponent!.url == ''
        ? InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              ),
              child: const Center(
                child: Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
            onTap: () {
              BlocProvider.of<WorkshopUiCubit>(context).activateImagePanel();
              BlocProvider.of<SinglenoteBloc>(context)
                  .add(AddImage(index: imageIndex));
            },
          )
        : InkWell(
            onTap: () {
              BlocProvider.of<WorkshopUiCubit>(context).activateImagePanel();
              BlocProvider.of<SinglenoteBloc>(context)
                  .add(ChangeCurrentImage(index: imageIndex));
            },
            child: // BlocBuilder<NotesBloc, NotesState>(
                //   builder: (context, state) {
                //     return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
                //         builder: (context, state) {
                //       return
                Container(
              decoration: BlocProvider.of<WorkshopUiCubit>(context)
                          .state
                          .isImageEditOpen &&
                      BlocProvider.of<SinglenoteBloc>(context)
                              .state
                              .currentImageIndex ==
                          imageIndex
                  ? BoxDecoration(
                      border: Border.all(
                          color: CustomColor.tertiaryColor, width: 2))
                  : null,
              child: ImageDisplay(
                imageComponent: imageComponent!,
                borderRadius: borderRadius,
              ),
            )

            ///;
            //     });
            //   },
            // ),
            );
  }
}

// class ImageContent extends StatelessWidget {
//   const ImageContent({
//     super.key,
//     required this.imageComponent,
//   });

//   final ImageComponent imageComponent;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Image.network(
//           imageComponent.url,
//           fit: imageComponent.fit,
//         ),
//         Container(
//           color: imageComponent.overlayColor
//               .withOpacity(imageComponent.overlayIntensity),
//         )
//       ],
//     );
//   }
// }
