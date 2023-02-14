import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_me/bloc/notes/notes_bloc.dart';
import 'package:wall_me/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/components/workshop/page_outline.dart';
import 'package:wall_me/components/workshop/templates_panel.dart';
import 'package:wall_me/components/workshop/workshop_board.dart';
import 'package:wall_me/global_functions.dart';

import '../bloc/single_note/single_note_bloc.dart';
import '../components/workshop/template_card.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WorkshopUiCubit>(
            create: ((context) => WorkshopUiCubit()),
          ),
          BlocProvider<NotesBloc>(
            create: ((context) => NotesBloc()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Wall Note Workshop'),
              elevation: 0,
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () {
                    BlocProvider.of<WorkshopUiCubit>(context).toggleOutline();
                  },
                );
              })),
          body: Row(
            children: const [
              PageOutline(),
              Expanded(child: WorkshopBoard()),
              TemplatesPanel()
            ],
          ),
        ));
  }
}
