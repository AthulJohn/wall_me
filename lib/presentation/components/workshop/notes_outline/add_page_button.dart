import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';

import '../../../../constants/color_pallette.dart';
import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../logic/models/workshop/singlenote_model.dart';

class AddPageButton extends StatelessWidget {
  const AddPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: InkWell(
        onTap: () {
          // Save the current Note
          BlocProvider.of<NotesBloc>(context).add(SetSingleNote(
              BlocProvider.of<SinglenoteBloc>(context).state.note));

          // Add a new Note to the notes list.
          BlocProvider.of<NotesBloc>(context).add(AddNotes(templateIndex: -1));

          // Set the new note as the editing note (in the editer).
          BlocProvider.of<SinglenoteBloc>(context).add(SetNote(
              BlocProvider.of<NotesBloc>(context).state.currentNote ??
                  SingleNote()));

          // Change to Templates Panel
          BlocProvider.of<WorkshopUiCubit>(context).activateTemplatePanel();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Container(
              decoration: BoxDecoration(
                  color: CustomColor.secondaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    Icons.add,
                    color: CustomColor.tertiaryColor,
                    size: 30,
                  ))),
        ),
      ),
    );
  }
}
