//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/bloc/notes/notes_bloc.dart';
import 'package:wall_me/models/workshop/text_component_model.dart';

import 'template widgets/image_widget.dart';
import 'template widgets/text_column.dart';

// Refer Template Varient Sheet for more details on how changes are done in the template
class Template1 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation
  ///
  const Template1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          switch (state.notesStatus) {
            case NotesStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case NotesStatus.error:
              return const Center(child: Text("Error"));
            case NotesStatus.success:
              // case NotesStatus.empty:
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(
                    [11, 12, 18, 17].contains(state.currentNote.templateId)
                        ? 20
                        : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: (state.currentNote.templateId == 16 ||
                              state.currentNote.templateId == 18)
                          ? 3
                          : 1,
                      child: [11, 13, 16, 17].contains(state.currentNote
                              .templateId) // If image is in the left side
                          ? FractionallySizedBox(
                              widthFactor: state.currentNote.templateId == 11 ||
                                      state.currentNote.templateId == 17
                                  ? 0.85
                                  : 1,
                              heightFactor:
                                  state.currentNote.templateId == 11 ||
                                          state.currentNote.templateId == 17
                                      ? 0.85
                                      : 1,
                              child: ImageWidget(
                                imageComponent: state
                                        .currentNote.imageComponents.isEmpty
                                    ? null
                                    : state.currentNote.imageComponents.first,
                              ),
                            )
                          : state.currentNote.textComponents.isEmpty
                              ? const Center(child: Text('An Error Occured!'))
                              : TextColumn(
                                  // textComponents:
                                  //     state.currentNote.textComponents.first,
                                  ),
                    ),
                    Expanded(
                      flex: (state.currentNote.templateId == 15 ||
                              state.currentNote.templateId == 17)
                          ? 3
                          : 1,
                      child: [12, 14, 15, 18].contains(state.currentNote
                              .templateId) // If image is in the left side
                          ? FractionallySizedBox(
                              widthFactor: state.currentNote.templateId == 12 ||
                                      state.currentNote.templateId == 18
                                  ? 0.85
                                  : 1,
                              heightFactor:
                                  state.currentNote.templateId == 12 ||
                                          state.currentNote.templateId == 18
                                      ? 0.85
                                      : 1,
                              child: ImageWidget(
                                imageComponent: state
                                        .currentNote.imageComponents.isEmpty
                                    ? null
                                    : state.currentNote.imageComponents.first,
                              ),
                            )
                          : state.currentNote.textComponents.isEmpty
                              ? const Center(child: Text('An Error Occured!'))
                              : TextColumn(
                                  // textComponents:
                                  //     state.currentNote.textComponents.first,
                                  ),
                    ),
                  ],
                ),
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
