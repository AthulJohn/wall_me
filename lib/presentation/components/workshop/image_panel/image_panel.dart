// import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';

import '../../../../constants/text_styles.dart';
// import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../../color_picker/color_Picker_text.dart';
import 'image_fit_buttons.dart';

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: state.isImageEditOpen ? max(180, getWidth(context) * 0.2) : 0,
        child: const ImagePanelBody(),
      );
    });
  }
}

class ImagePanelBody extends StatelessWidget {
  const ImagePanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
                builder: (context, state) {
              return Text(
                state.isBackground ? "Background Options" : "Image Options",
                style: CustomTextStyles.panelTitle,
              );
            }),
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(CustomColor.tertiaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: const MaterialStatePropertyAll(StadiumBorder())),
              child: const Text('Add/Change Image'),
              onPressed: () {
                BlocProvider.of<SinglenoteBloc>(context).add(AddImage());
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                    child: Text('Image Fit')),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    ImageCoverButton(),
                    SizedBox(
                      width: 5,
                    ),
                    ImageContainButton(),
                    SizedBox(
                      width: 5,
                    ),
                    ImageFillButton(),
                  ],
                ),
                const SizedBox(height: 10),
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topLeft,
                  child: Text("Overlay Color"),
                ),
                // FittedBox(
                //   fit: BoxFit.scaleDown,
                //   child: BlocBuilder<SinglenoteBloc, SinglenoteState>(
                //     builder: (context, notestate) {
                //       return SizedBox(
                //         // width: 150,
                //         height: 400,
                //         child: ColorIndicator(
                //           color: ((notestate.currentImage ??
                //                   ImageComponent(overlayColor: Colors.black))
                //               .overlayColor),
                // availableColors: const [
                //   Colors.black,
                //   Colors.grey,
                //   Colors.white,
                //   Colors.red,
                //   Colors.green,
                //   Colors.blue,
                //   Colors.yellow,
                //   Colors.orange,
                //   Colors.purple,
                //   Colors.pink
                // ],
                // onColorChanged: (color) {
                //   BlocProvider.of<SinglenoteBloc>(context).add(
                //       ChangeImageStyle(
                //           (notestate.currentImage ?? ImageComponent())
                //               .copyWith(overlayColor: color)));
                // },
                // useInShowDialog: false,
                //         ),
                //       );
                //     },
                //   ),
                // ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ColorPickerWithText(
                    colorPickerType: ColorPickerType.image,
                  ),
                ),
                const SizedBox(height: 10),
                const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                    child: Text("Overlay Opacity")),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: BlocBuilder<SinglenoteBloc, SinglenoteState>(
                    builder: (context, notestate) {
                      return Slider(
                        value: (notestate.currentImage ?? ImageComponent())
                            .overlayIntensity,
                        onChanged: (value) {
                          BlocProvider.of<SinglenoteBloc>(context).add(
                            ChangeImageStyle(
                              (notestate.currentImage ?? ImageComponent())
                                  .copyWith(overlayIntensity: value),
                            ),
                          );
                        },
                        min: 0,
                        max: 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
