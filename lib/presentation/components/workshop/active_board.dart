import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';
import 'package:wall_me/presentation/components/workshop/select_template_note.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_editers/template_1.dart';

import '../../../logic/bloc/notes/notes_bloc.dart';
import 'buttons.dart';
import 'templates/template_editers/template_0.dart';
import 'templates/template_editers/template_2.dart';
import 'templates/template_editers/template_3.dart';

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

  Widget chooseTemplate(int templateId) {
    switch ((templateId / 10).floor()) {
      case 0:
        return const Template0();
      case 1:
        return const Template1();
      case 2:
        return const Template2();
      case 3:
        return const Template3();
      default:
        return const Template1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.currentNoteIndex > 0)
          const SizedBox(
            height: 30,
          ),
        if (state.currentNoteIndex > 0)
          Tooltip(
            message: "Previous Page",
            child: CustomCircleButton(
                onPressed: () {
                  changePage(context, NavDirection.up);
                },
                icon: Icons.keyboard_arrow_up),
          ),
        const Spacer(),
        FractionallySizedBox(
          widthFactor: 0.85,
          child:
              (state.currentNote ?? SingleNote(templateId: -1)).templateId == -1
                  ? const SelectTemplateNote()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Spacer(),
                              Tooltip(
                                message: "Edit Background",
                                child: CustomCircleButton(
                                    onPressed: () {
                                      BlocProvider.of<SinglenoteBloc>(context)
                                          .add(ActivateBackgroundImagePanel());
                                      BlocProvider.of<WorkshopUiCubit>(context)
                                          .activateBGImagePanel();
                                    },
                                    icon: Icons.imagesearch_roller_rounded),
                              ),
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: chooseTemplate(
                              BlocProvider.of<SinglenoteBloc>(context)
                                  .state
                                  .note
                                  .templateId),
                        ),
                      ],
                    ),
        ),
        const Spacer(),
        if (state.currentNoteIndex < state.notes.length - 1)
          Tooltip(
            message: "Next Page",
            child: CustomCircleButton(
                onPressed: () {
                  changePage(context, NavDirection.down);
                },
                icon: Icons.keyboard_arrow_down),
          ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
