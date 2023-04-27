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
class Template3 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation

  const Template3({
    super.key,
  });

  bool templateIsIn(SingleNote state, List<int> templateId) {
    /// Checks if the current template is in the list of templates
    return templateId.contains(state.templateId);
  }

  Widget getImageComponent(SinglenoteState state, List<int> bordertemplates) {
    return ImageWidget(
      imageComponent: state.note.imageComponents.isEmpty
          ? null
          : state.note.imageComponents.first,
      borderRadius: templateIsIn(state.note, bordertemplates) ? 10 : 0,
      imageIndex: 0,
    );
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: templateIsIn(state.note, [31, 33, 35]) ? 3 : 1,
                        child: templateIsIn(state.note,
                                [31, 33, 35]) // If image is in the top
                            ? FractionallySizedBox(
                                alignment: Alignment.bottomCenter,
                                widthFactor: templateIsIn(
                                        state.note, [31, 32, 33, 34, 36])
                                    ? 0.85
                                    : 1,
                                heightFactor: templateIsIn(
                                        state.note, [31, 32, 33, 34, 36])
                                    ? 0.93
                                    : 1,
                                child: state.note.templateId == 31
                                    ? Center(
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: getImageComponent(
                                                state, [31, 33])),
                                      )
                                    : getImageComponent(state, [31, 33]))
                            : state.note.textComponents.isEmpty
                                ? const Center(child: Text('An Error Occured'))
                                : const TextColumn(
                                    alignment: Alignment.bottomCenter,
                                    // textComponents:
                                    //     state.note.textComponents.first,
                                  ),
                      ),
                      Expanded(
                        flex: templateIsIn(state.note, [32, 34, 36]) ? 3 : 1,
                        child: templateIsIn(state.note,
                                [32, 34, 36]) // If image is in the bottom
                            ? FractionallySizedBox(
                                alignment: Alignment.topCenter,
                                widthFactor: templateIsIn(
                                        state.note, [31, 32, 33, 34, 35])
                                    ? 0.85
                                    : 1,
                                heightFactor: templateIsIn(
                                        state.note, [31, 32, 33, 34, 35])
                                    ? 0.93
                                    : 1,
                                child: state.note.templateId == 32
                                    ? Center(
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: getImageComponent(
                                                state, [32, 34])),
                                      )
                                    : getImageComponent(state, [32, 34]),
                              )
                            : state.note.textComponents.isEmpty
                                ? const Center(child: Text('An Error Occured!'))
                                : const TextColumn(
                                    alignment: Alignment.topCenter,
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
