import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../close_button.dart';
import 'image_fit_buttons.dart';

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: state.isImageEditOpen ? max(180, getWidth(context) * 0.25) : 0,
        child: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.all(8),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Image Options"),
              ),
              const SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: TextButton(
                  child: const Text('Change Image'),
                  onPressed: () {
                    BlocProvider.of<NotesBloc>(context).add(AddImage());
                  },
                ),
              ),
              const SizedBox(height: 10),
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
                child: Text("Overlay Color"),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: BlocBuilder<NotesBloc, NotesState>(
                  builder: (context, notestate) {
                    return SizedBox(
                      // width: 150,
                      height: 400,
                      child: BlockPicker(
                        pickerColor: ((notestate.currentImage ??
                                ImageComponent(overlayColor: Colors.black))
                            .overlayColor),
                        onColorChanged: (color) {
                          BlocProvider.of<NotesBloc>(context)
                              .add(ChangeImageColor(color));
                        },
                        useInShowDialog: false,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const FittedBox(
                  fit: BoxFit.scaleDown, child: Text("Overlay Opacity")),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: BlocBuilder<NotesBloc, NotesState>(
                  builder: (context, state) {
                    return Slider(
                      value: (state.currentImage != null
                              ? state.currentImage!
                              : ImageComponent())
                          .overlayIntensity,
                      onChanged: (value) {
                        BlocProvider.of<NotesBloc>(context)
                            .add(ChangeImageColorOpacity(value));
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
      );
    });
  }
}
