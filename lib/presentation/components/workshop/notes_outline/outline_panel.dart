import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/presentation/components/workshop/notes_outline/add_page_button.dart';
import 'package:wall_me/presentation/components/workshop/notes_outline/non_selected_template.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_1_display.dart';

import '../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../../../../logic/models/workshop/singlenote_model.dart';

class PageOutline extends StatelessWidget {
  final bool isExpanded;
  const PageOutline({super.key, this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
      builder: (context, state) {
        return AnimatedContainer(
            color: CustomColor.darkblue,
            duration: const Duration(milliseconds: 100),
            width: state.isOutlineOpen ? max(180, getWidth(context) * 0.15) : 0,
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

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue,
        padding: const EdgeInsets.all(8),
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
                                          color: CustomColor.tertiaryColor,
                                          width: 2))
                                  : null,
                              child: InkWell(
                                child: state.notes[index].templateId == -1
                                    ? const NonSelectedTemplateOutline()
                                    : index == state.currentNoteIndex
                                        ? BlocBuilder<SinglenoteBloc,
                                                SinglenoteState>(
                                            builder: (context, state) {
                                            return ViewTemplate1(
                                                note: state.note,
                                                isOutline: true);
                                          })
                                        : ViewTemplate1(
                                            note: state.notes[index],
                                            isOutline: true),
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
        ));
  }
}
