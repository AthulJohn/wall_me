import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/presentation/components/workshop/notes_outline/add_page_button.dart';
import 'package:wall_me/presentation/components/workshop/notes_outline/non_selected_template.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_displays/template_0_display.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_displays/template_1_display.dart';

import '../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../../../../logic/models/workshop/singlenote_model.dart';
import '../templates/template_displays/template_2_display.dart';
import '../templates/template_displays/template_3_display.dart';

class PageOutline extends StatelessWidget {
  final bool isExpanded;
  const PageOutline({super.key, this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
      builder: (context, state) {
        return AnimatedContainer(
            color: Colors.white,
            // color: CustomColor.darkblue,
            duration: const Duration(milliseconds: 100),
            width: state.isOutlineOpen ? max(210, getWidth(context) * 0.15) : 0,
            child: const PageOutlineBody());
      },
    );
  }
}

class PageOutlineBody extends StatelessWidget {
  const PageOutlineBody({
    super.key,
  });
  void changePage(context, int ind) {
    BlocProvider.of<NotesBloc>(context).add(
        SetSingleNote(BlocProvider.of<SinglenoteBloc>(context).state.note));
    BlocProvider.of<NotesBloc>(context).add(GoToPage(
        index: ind, singlenoteBloc: BlocProvider.of<SinglenoteBloc>(context)));
  }

  Widget chooseTemplate(int templateId, SingleNote note) {
    switch ((templateId / 10).floor()) {
      case 0:
        return ViewTemplate0(note: note, isOutline: true);
      case 1:
        return ViewTemplate1(note: note, isOutline: true);
      case 2:
        return ViewTemplate2(note: note, isOutline: true);
      case 3:
        return ViewTemplate3(note: note, isOutline: true);
      default:
        return ViewTemplate1(note: note, isOutline: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue,
        padding: EdgeInsets.symmetric(
            vertical: getRelSize(25, context),
            horizontal: getRelSize(15, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                "WallMe",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "Montserrat"),
              ),
            ),
            const Divider(),
            const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                "Design",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      if (index < state.notes.length) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    decoration: state.currentNoteIndex == index
                                        ? BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    CustomColor.tertiaryColor,
                                                width: 2))
                                        : null,
                                    child: InkWell(
                                      child: state.notes[index].templateId == -1
                                          ? const NonSelectedTemplateOutline()
                                          : index == state.currentNoteIndex
                                              ? BlocBuilder<SinglenoteBloc,
                                                      SinglenoteState>(
                                                  builder: (context, state) {
                                                  return chooseTemplate(
                                                      state.note.templateId,
                                                      state.note);
                                                })
                                              : chooseTemplate(
                                                  state.notes[index].templateId,
                                                  state.notes[index]),
                                      onTap: () {
                                        changePage(context, index);
                                      },
                                    ),
                                  )),
                            ),
                          ],
                        );
                      } else {
                        return const AddPageButton();
                      }
                    },
                    separatorBuilder: (context, ind) => Divider(),
                    itemCount: state.notes.length + 1,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
