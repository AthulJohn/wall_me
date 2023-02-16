//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';

import 'template widgets/image_widget.dart';
import 'template widgets/text_column.dart';

// Refer Template Varient Sheet for more details on how changes are done in the template
class Template1 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation

  const Template1({
    super.key,
  });

  bool templateIsIn(NotesState state, List<int> templateId) {
    /// Checks if the current template is in the list of templates
    return templateId.contains(state.currentNote!.templateId);
  }

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
                    templateIsIn(state, [11, 12, 18, 17]) ? 20 : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: templateIsIn(state, [16, 18]) ? 3 : 1,
                      child: templateIsIn(state,
                              [11, 13, 16, 17]) // If image is in the left side
                          ? FractionallySizedBox(
                              widthFactor:
                                  templateIsIn(state, [11, 17]) ? 0.85 : 1,
                              heightFactor:
                                  templateIsIn(state, [11, 17]) ? 0.85 : 1,
                              child: ImageWidget(
                                imageComponent: state
                                        .currentNote!.imageComponents.isEmpty
                                    ? null
                                    : state.currentNote!.imageComponents.first,
                                borderRadius:
                                    templateIsIn(state, [11, 17]) ? 10 : 0,
                                imageIndex: 0,
                              ),
                            )
                          : state.currentNote!.textComponents.isEmpty
                              ? const Center(child: Text('An Error Occured!'))
                              : const TextColumn(
                                  // textComponents:
                                  //     state.currentNote.textComponents.first,
                                  ),
                    ),
                    Expanded(
                      flex: templateIsIn(state, [15, 17]) ? 3 : 1,
                      child: templateIsIn(state,
                              [12, 14, 15, 18]) // If image is in the left side
                          ? FractionallySizedBox(
                              widthFactor:
                                  templateIsIn(state, [12, 18]) ? 0.85 : 1,
                              heightFactor:
                                  templateIsIn(state, [12, 18]) ? 0.85 : 1,
                              child: ImageWidget(
                                imageComponent: state
                                        .currentNote!.imageComponents.isEmpty
                                    ? null
                                    : state.currentNote!.imageComponents.first,
                                borderRadius:
                                    templateIsIn(state, [12, 18]) ? 10 : 0,
                                imageIndex: 0,
                              ),
                            )
                          : state.currentNote!.textComponents.isEmpty
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
