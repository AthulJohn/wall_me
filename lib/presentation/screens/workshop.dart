import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'package:wall_me/logic/data_cleaning/put_functions.dart';
import 'package:wall_me/presentation/components/workshop/image_panel/image_panel.dart';
import 'package:wall_me/presentation/components/workshop/template_panel/templates_panel.dart';
import 'package:wall_me/presentation/components/workshop/text_panel/text_panel.dart';
import 'package:wall_me/presentation/components/workshop/workshop_board.dart';

import '../../global_functions.dart';
import '../../logic/bloc/textfield/textfield_cubit.dart';
import '../components/workshop/buttons.dart';
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
          BlocProvider<TextFieldCubit>(
            create: ((context) => TextFieldCubit()),
          ),
        ],
        child: Scaffold(
          backgroundColor: CustomColor.backgroundColor,
          appBar: AppBar(
            backgroundColor: CustomColor.primaryColor,
            title: const Text(
              'Wall Note Workshop',
              // style: TextStyle(fontFamily: 'Cool Crayon'),
            ),
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
              Center(
                child: Builder(
                  builder: (context) {
                    return CustomElevatedButton(
                      text: 'Share',
                      icon: Icons.upload,
                      onPressed: () async {
                        if (BlocProvider.of<NotesBloc>(context)
                            .state
                            .notes
                            .isNotEmpty) {
                          // bool result = await SendFunctions.sendSiteCleanData(
                          //     'count',
                          //     BlocProvider.of<NotesBloc>(context).state.notes);
                          // print(result);
                          context.push('/workshop/preview');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Add Atleast 1 page to share your site')));
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Center(
                child: Builder(
                  builder: (context) {
                    return CustomElevatedButton(
                      text: 'Publish',
                      icon: Icons.upload,
                      onPressed: () async {
                        if (BlocProvider.of<NotesBloc>(context)
                            .state
                            .notes
                            .isNotEmpty) {
                          context.push('/workshop/selectUrl');
                          // context.push('/workshop/preview');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Add Atleast 1 page to share your site')));
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
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
