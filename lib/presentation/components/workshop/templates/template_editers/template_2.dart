//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/decoration_image_component.dart';

import '../../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../../logic/models/workshop/image_component_model.dart';
import '../../../../../logic/models/workshop/singlenote_model.dart';
import '../template widgets/image_widget.dart';
import '../template widgets/text_column.dart';

// Refer Template Varient Sheet for more details on how changes are done in the template
class Template2 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation

  const Template2({
    super.key,
  });

  bool templateIsIn(SingleNote state, List<int> templateId) {
    /// Checks if the current template is in the list of templates
    return templateId.contains(state.templateId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<SinglenoteBloc, SinglenoteState>(
        builder: (context, state) {
          switch (state.noteStatus) {
            case LoadingStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case LoadingStatus.error:
              return const Center(child: Text("Error"));
            case LoadingStatus.success:
              ImageComponent? backgroundImage =
                  state.note.imageComponents.length >
                          (totalImagesPerTemplate[state.note.templateId] ?? 1)
                      ? state.note.imageComponents[
                          (totalImagesPerTemplate[state.note.templateId] ?? 1)]
                      : null;
              return Container(
                decoration: backgroundImage != null
                    ? BoxDecoration(
                        image: backgroundImage.url.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(backgroundImage.url),
                                fit: backgroundImage.fit)
                            : null,
                      )
                    : null,
                child: Container(
                  padding: EdgeInsets.all(
                      templateIsIn(state.note, [11, 12, 18, 17]) ? 20 : 0),
                  color: backgroundImage?.overlayColor
                      .withOpacity(backgroundImage.overlayIntensity),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: templateIsIn(state.note, [16, 18]) ? 3 : 1,
                        child: templateIsIn(state.note, [
                          11,
                          13,
                          16,
                          17
                        ]) // If image is in the left side
                            ? FractionallySizedBox(
                                widthFactor: templateIsIn(state.note, [11, 17])
                                    ? 0.85
                                    : 1,
                                heightFactor: templateIsIn(state.note, [11, 17])
                                    ? 0.85
                                    : 1,
                                child: ImageWidget(
                                  imageComponent:
                                      state.note.imageComponents.isEmpty
                                          ? null
                                          : state.note.imageComponents.first,
                                  borderRadius:
                                      templateIsIn(state.note, [11, 17])
                                          ? 10
                                          : 0,
                                  imageIndex: 0,
                                ),
                              )
                            : state.note.textComponents.isEmpty
                                ? const Center(child: Text('An Error Occured'))
                                : const TextColumn(
                                    // textComponents:
                                    //     state.note.textComponents.first,
                                    ),
                      ),
                      Expanded(
                        flex: templateIsIn(state.note, [15, 17]) ? 3 : 1,
                        child: templateIsIn(state.note, [
                          12,
                          14,
                          15,
                          18
                        ]) // If image is in the right side
                            ? FractionallySizedBox(
                                widthFactor: templateIsIn(state.note, [12, 18])
                                    ? 0.85
                                    : 1,
                                heightFactor: templateIsIn(state.note, [12, 18])
                                    ? 0.85
                                    : 1,
                                child: ImageWidget(
                                  imageComponent:
                                      state.note.imageComponents.isEmpty
                                          ? null
                                          : state.note.imageComponents.first,
                                  borderRadius:
                                      templateIsIn(state.note, [12, 18])
                                          ? 10
                                          : 0,
                                  imageIndex: 0,
                                ),
                              )
                            : state.note.textComponents.isEmpty
                                ? const Center(child: Text('An Error Occured!'))
                                : const TextColumn(
                                    // textComponents:
                                    //     state.currentNote.textComponents.first,
                                    ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
