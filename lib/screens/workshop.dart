import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wall_me/bloc/notes/notes_bloc.dart';
import 'package:wall_me/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/components/workshop/page_outline.dart';
import 'package:wall_me/components/workshop/templates_panel.dart';
import 'package:wall_me/global_functions.dart';

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
              leading: IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  BlocProvider.of<WorkshopUiCubit>(context).toggleOutline();
                },
              )),
          body: Row(
            children: [
              const PageOutline(),
              Expanded(
                child: Container(
                  child: Column(
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
                          children: [
                            const Expanded(
                              child: TemplateCard(
                                templateIndex: 1,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Image.asset(
                                "assets/images/components/Template_2.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/components/Template_3.png",
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Image.asset(
                                "assets/images/components/Template_4.png",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TemplatesPanel()
            ],
          ),
        ));
  }
}
