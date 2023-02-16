import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_1_display.dart';

import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';

class PageOutline extends StatelessWidget {
  final bool isExpanded;
  const PageOutline({super.key, this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
      builder: (context, state) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: state.isOutlineOpen ? max(180, getWidth(context) * 0.15) : 0,
            child: const PageOutlineBody());
      },
    );
  }
}

class PageOutlineBody extends StatelessWidget {
  const PageOutlineBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ViewTemplate1(note: state.notes[index]));
              },
              itemCount: state.notes.length,
            );
          },
        ));
  }
}
