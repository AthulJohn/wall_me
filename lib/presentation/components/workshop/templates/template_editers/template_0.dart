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
class Template0 extends StatelessWidget {
  /// Requires 1 image (Template 02/03) or 1 text component (Template 01)
  /// Next image (Image 0 for Template 01, Image 1 for Template 02/03) is optional to be background image
  const Template0({
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
                      child: state.note.templateId == 1
                          ? const TextColumn(
                              // textComponents:
                              //     state.note.textComponents.first,
                              )
                          : FractionallySizedBox(
                              widthFactor: 0.85,
                              heightFactor: 0.85,
                              child: state.note.templateId == 2
                                  ? Center(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: ImageWidget(
                                          imageComponent:
                                              state.note.imageComponents.isEmpty
                                                  ? null
                                                  : state.note.imageComponents
                                                      .first,
                                          borderRadius: 10,
                                          imageIndex: 0,
                                        ),
                                      ),
                                    )
                                  : ImageWidget(
                                      imageComponent: state
                                              .note.imageComponents.isEmpty
                                          ? null
                                          : state.note.imageComponents.first,
                                      borderRadius: 10,
                                      imageIndex: 0,
                                    ),
                            )));
          }
        },
      ),
    );
  }
}
