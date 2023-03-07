import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';
import 'package:wall_me/presentation/components/workshop/select_template_note.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_1.dart';

import '../../../logic/bloc/notes/notes_bloc.dart';
import 'buttons.dart';

enum NavDirection { up, down }

class ActiveBoard extends StatelessWidget {
  final NotesState state;
  const ActiveBoard(this.state, {super.key});

  void changePage(context, NavDirection dir) {
    BlocProvider.of<NotesBloc>(context).add(
        SetSingleNote(BlocProvider.of<SinglenoteBloc>(context).state.note));
    if (dir == NavDirection.up) {
      BlocProvider.of<NotesBloc>(context)
          .add(PreviousPage(BlocProvider.of<SinglenoteBloc>(context)));
    } else {
      BlocProvider.of<NotesBloc>(context)
          .add(NextPage(BlocProvider.of<SinglenoteBloc>(context)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.85,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.currentNoteIndex > 0)
              const SizedBox(
                height: 30,
              ),
            if (state.currentNoteIndex > 0)
              CustomCircleButton(
                  onPressed: () {
                    changePage(context, NavDirection.up);
                  },
                  icon: Icons.keyboard_arrow_up),
            const Spacer(),
            (state.currentNote ?? SingleNote(templateId: -1)).templateId == -1
                ? const SelectTemplateNote()
                : const AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Template1(),
                  ),
            const Spacer(),
            CustomCircleButton(
                onPressed: () {
                  BlocProvider.of<SinglenoteBloc>(context)
                      .add(ActivateBackgroundImagePanel());
                  BlocProvider.of<WorkshopUiCubit>(context)
                      .activateImagePanel();
                },
                icon: Icons.imagesearch_roller_rounded),
            if (state.currentNoteIndex < state.notes.length - 1)
              CustomCircleButton(
                  onPressed: () {
                    changePage(context, NavDirection.down);
                  },
                  icon: Icons.keyboard_arrow_down),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
