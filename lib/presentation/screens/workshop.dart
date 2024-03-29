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
import 'package:wall_me/presentation/components/workshop/publish_panel.dart';
import 'package:wall_me/presentation/components/workshop/template_panel/templates_panel.dart';
import 'package:wall_me/presentation/components/workshop/text_panel/text_panel.dart';
import 'package:wall_me/presentation/components/workshop/workshop_board.dart';

import '../../global_functions.dart';
import '../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../logic/bloc/site_data/sitedata_cubit.dart';
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
          BlocProvider<SinglenoteBloc>(
            create: ((context) => SinglenoteBloc()),
          ),
          BlocProvider<SitedataCubit>(create: (context) => SitedataCubit()),
        ],
        child: Scaffold(
          backgroundColor: CustomColor.backgroundColor,
          // appBar: AppBar(
          //   backgroundColor: CustomColor.backgroundColor,
          //   // title: const Text(
          //   //   'Wall Note Workshop',
          //   //   // style: TextStyle(fontFamily: 'Cool Crayon'),
          //   // ),
          //   elevation: 0,
          //   leading: Builder(
          //     builder: (context) {
          //       return IconButton(
          //         icon: const Icon(Icons.menu_rounded),
          //         onPressed: () {
          //
          //         },
          //       );
          //     },
          //   ),
          //   // actions:
          // ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Row(
                children: [
                  const PageOutline(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.white,
                          height: 50,
                          child: Builder(builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // IconButton(
                                //     icon: Icon(
                                //       Icons.menu_open,
                                //       color: CustomColor.tertiaryColor,
                                //     ),
                                //     onPressed: () {
                                //       BlocProvider.of<WorkshopUiCubit>(context)
                                //           .toggleOutline();
                                //     }),
                                // const Spacer(),
                                Center(
                                  child: Builder(
                                    builder: (context) {
                                      return CustomElevatedButton(
                                        text: 'Preview',
                                        icon: Icons.play_arrow,
                                        onPressed: () async {
                                          BlocProvider.of<NotesBloc>(context)
                                              .add(SetSingleNote(BlocProvider
                                                      .of<SinglenoteBloc>(
                                                          context)
                                                  .state
                                                  .note));
                                          if (BlocProvider.of<NotesBloc>(
                                                  context)
                                              .state
                                              .notes
                                              .isNotEmpty) {
                                            // bool result = await SendFunctions.sendSiteCleanData(
                                            //     'count',
                                            //     BlocProvider.of<NotesBloc>(context).state.notes);
                                            // print(result);
                                            context.push('/workshop/preview');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
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
                                          BlocProvider.of<NotesBloc>(context)
                                              .add(SetSingleNote(BlocProvider
                                                      .of<SinglenoteBloc>(
                                                          context)
                                                  .state
                                                  .note));
                                          if (BlocProvider.of<NotesBloc>(
                                                  context)
                                              .state
                                              .notes
                                              .isNotEmpty) {
                                            BlocProvider.of<TextFieldCubit>(
                                                    context)
                                                .changeText('');
                                            BlocProvider.of<WorkshopUiCubit>(
                                                    context)
                                                .openPublishPanel();
                                            // context.push('/workshop/selectUrl');
                                            // context.push('/workshop/preview');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
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
                            );
                          }),
                        ),
                        Expanded(
                          child: Row(
                            children: const [
                              Expanded(child: WorkshopBoard()),
                              PanelCloseButton(),
                              TemplatesPanel(),
                              ImagePanel(),
                              TextEditPanel(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const PublishPanel(),
            ],
          ),
        ));
  }
}
