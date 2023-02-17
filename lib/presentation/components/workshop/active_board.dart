import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';
import 'package:wall_me/presentation/components/workshop/select_template_note.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_1.dart';

import '../../../logic/bloc/notes/notes_bloc.dart';

class ActiveBoard extends StatelessWidget {
  final NotesState state;
  const ActiveBoard(this.state, {super.key});

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
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<NotesBloc>(context).add(PreviousPage());
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<StadiumBorder>(
                          const StadiumBorder()),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15))),
                  child: const Text('Previous Page')),
            const Spacer(),
            (state.currentNote ?? SingleNote(templateId: -1)).templateId == -1
                ? const SelectTemplateNote()
                : const AspectRatio(aspectRatio: 16 / 9, child: Template1()),
            const Spacer(),
            if (state.currentNoteIndex < state.notes.length - 1)
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<NotesBloc>(context).add(NextPage());
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<StadiumBorder>(
                          const StadiumBorder()),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15))),
                  child: const Text('Next Page')),
            const SizedBox(
              height: 30,
            )
          ],
        ));
  }
}
