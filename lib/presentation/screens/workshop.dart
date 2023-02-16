import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/presentation/components/workshop/image_panel/image_panel.dart';
import 'package:wall_me/presentation/components/workshop/template_panel/templates_panel.dart';
import 'package:wall_me/presentation/components/workshop/text_panel/text_panel.dart';
import 'package:wall_me/presentation/components/workshop/workshop_board.dart';
import 'package:wall_me/presentation/screens/display.dart';

import '../../logic/bloc/textfield/textfield_cubit.dart';
import '../components/workshop/close_button.dart';
import '../components/workshop/notes_outline/outline_panel.dart';

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
          BlocProvider<TextFieldCubit>(
            create: ((context) => TextFieldCubit()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Wall Note Workshop'),
            elevation: 0,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () {
                    BlocProvider.of<WorkshopUiCubit>(context).toggleOutline();
                  },
                );
              },
            ),
            actions: [
              Builder(
                builder: (context) {
                  return Container(
                    color: Colors.green,
                    child: TextButton(
                      child: const Text('Share'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (newcontext) => DisplayScreen(
                                BlocProvider.of<NotesBloc>(context)
                                    .state
                                    .notes)));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: Row(
            children: const [
              PageOutline(),
              Expanded(child: WorkshopBoard()),
              PanelCloseButton(),
              TemplatesPanel(),
              ImagePanel(),
              TextEditPanel()
            ],
          ),
        ));
  }
}
