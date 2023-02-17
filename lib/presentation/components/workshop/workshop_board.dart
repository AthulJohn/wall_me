import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/presentation/components/workshop/active_board.dart';
import 'package:wall_me/presentation/components/workshop/select_template_note.dart';

import '../../../logic/bloc/notes/notes_bloc.dart';
import 'template_panel/template_card.dart';

class WorkshopBoard extends StatelessWidget {
  const WorkshopBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        switch (state.notesStatus) {
          case NotesStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case NotesStatus.error:
            return const Center(child: Text("Error"));
          case NotesStatus.success:
            return ActiveBoard(state);
          case NotesStatus.initial:
            return const SelectTemplateNote();
          default:
            return const Center(child: Text("other"));
        }
      },
    );
  }
}
