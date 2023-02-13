import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_me/components/workshop/active_board.dart';

import '../../bloc/notes/notes_bloc.dart';
import 'template_card.dart';

class WorkshopBoard extends StatelessWidget {
  const WorkshopBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          switch (state.notesStatus) {
            case NotesStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case NotesStatus.error:
              return const Center(child: Text("Error"));
            case NotesStatus.success:
              return ActiveBoard(state);
            case NotesStatus.initial:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Select a template to get started...",
                    style: GoogleFonts.poppins(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Row(
                      children: const [
                        Expanded(
                          child: TemplateCard(
                            templateIndex: 1,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TemplateCard(
                            templateIndex: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Row(
                      children: const [
                        Expanded(
                          child: TemplateCard(
                            templateIndex: 3,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TemplateCard(
                            templateIndex: 4,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            default:
              return Center(child: Text("other"));
          }
        },
      ),
    );
  }
}
