import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../close_button.dart';

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: state.isTemplatesOpen ? max(180, getWidth(context) * 0.25) : 0,
        child: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Image Options"),
              ),
              const SizedBox(height: 10),
              TextButton(
                child: const Text('Change Image'),
                onPressed: () {
                  BlocProvider.of<NotesBloc>(context).add(AddImage());
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // Container(child: IconButton(icon: ),)
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
