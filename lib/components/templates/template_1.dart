//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/bloc/notes/notes_bloc.dart';
import 'package:wall_me/models/workshop/text_component_model.dart';

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
                                  ? 0.75
                                  : 1,
                              heightFactor:
                                  state.currentNote.templateId == 11 ||
                                          state.currentNote.templateId == 17
                                      ? 0.75
                                      : 1,
                              child: state.currentNote.imageComponents.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.add_photo_alternate_rounded,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            // BlocProvider.of<SingleNoteBloc>(
                                            //         context)
                                            //     .add(UploadImage());
                                            BlocProvider.of<NotesBloc>(context)
                                                .add(AddImage());
                                          },
                                        ),
                                      ))
                                  : Image.network(
                                      state.currentNote.imageComponents.first
                                          .url,
                                      fit: BoxFit.cover,
                                    ))
                          : state.currentNote.textComponents.isNotEmpty
                              ? Column(children: [
                                  for (TextComponent tc
                                      in state.currentNote.textComponents.first)
                                    Text(tc.text,
                                        style: TextStyle(
                                            fontSize: tc.fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: tc.fontColor)),
                                ])
                              : Container(),
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
                                  ? 0.75
                                  : 1,
                              heightFactor:
                                  state.currentNote.templateId == 12 ||
                                          state.currentNote.templateId == 18
                                      ? 0.75
                                      : 1,
                              child: state.currentNote.imageComponents.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.add_photo_alternate_rounded,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            // BlocProvider.of<SingleNoteBloc>(
                                            //         context)
                                            //     .add(UploadImage());
                                            BlocProvider.of<NotesBloc>(context)
                                                .add(AddImage());
                                          },
                                        ),
                                      ))
                                  : Image.network(
                                      state.currentNote.imageComponents.first
                                          .url,
                                      fit: BoxFit.cover,
                                    ))
                          : state.currentNote.textComponents.isNotEmpty
                              ? Column(children: [
                                  for (TextComponent tc
                                      in state.currentNote.textComponents.first)
                                    Text(tc.text,
                                        style: TextStyle(
                                            fontSize: tc.fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: tc.fontColor)),
                                ])
                              : Container(),
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
