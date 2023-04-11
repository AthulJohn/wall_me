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
                  color: backgroundImage?.overlayColor
                      .withOpacity(backgroundImage.overlayIntensity),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: templateIsIn(state.note,
                                [21, 23, 24, 25]) // If Left Side contains image
                            ? FractionallySizedBox(
                                widthFactor: templateIsIn(state.note, [21, 24])
                                    ? 0.85
                                    : 1,
                                heightFactor: templateIsIn(state.note, [21, 24])
                                    ? 0.85
                                    : 1,
                                child: ImageWidget(
                                  imageComponent:
                                      state.note.imageComponents.isEmpty
                                          ? null
                                          : state.note.imageComponents.first,
                                  borderRadius:
                                      templateIsIn(state.note, [21, 24])
                                          ? 10
                                          : 0,
                                  imageIndex: 0,
                                ),
                              )
                            : //Left Side has Text
                            state.note.textComponents.isEmpty
                                ? const Center(child: Text('An Error Occured'))
                                : const TextColumn(
                                    // textComponents:
                                    //     state.note.textComponents.first,
                                    ),
                      ),
                      Expanded(
                        child: templateIsIn(state.note,
                                [21, 23, 24, 25]) // If Right Side has image
                            ? FractionallySizedBox(
                                widthFactor: templateIsIn(state.note, [21, 25])
                                    ? 0.85
                                    : 1,
                                heightFactor: templateIsIn(state.note, [21, 25])
                                    ? 0.85
                                    : 1,
                                child: ImageWidget(
                                  imageComponent:
                                      state.note.imageComponents.length < 2
                                          ? null
                                          : state.note.imageComponents[1],
                                  borderRadius:
                                      templateIsIn(state.note, [21, 25])
                                          ? 10
                                          : 0,
                                  imageIndex: 1,
                                ),
                              )
                            : state.note.textComponents.isEmpty
                                ? const Center(child: Text('An Error Occured!'))
                                : const TextColumn(
                                    textColumnindex: 1,
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
