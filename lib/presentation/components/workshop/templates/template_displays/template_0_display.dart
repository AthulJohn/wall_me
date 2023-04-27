//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:wall_me/global_functions.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/text_column_display.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/text_column_preview.dart';

import '../../../../../constants/global_variables.dart';
import '../../../../../logic/models/workshop/image_component_model.dart';
import '../../../../../logic/models/workshop/singlenote_model.dart';
import '../template widgets/decoration_image_component.dart';
import '../template widgets/image_widget_display.dart';

// Refer Template Varient Sheet for more details on how changes are done in the template
class ViewTemplate0 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation
  final SingleNote note;
  final bool isOutline;
  const ViewTemplate0({super.key, required this.note, this.isOutline = false});

  bool templateIsIn(int id, List<int> templateId) {
    /// Checks if the current template is in the list of templates
    return templateId.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      ImageComponent? backgroundImage = note.imageComponents.length >
              (totalImagesPerTemplate[note.templateId] ?? 1)
          ? note.imageComponents[(totalImagesPerTemplate[note.templateId] ?? 1)]
          : null;
      return Container(
        color: Colors.white,
        child: Container(
            decoration: backgroundImage != null
                ? BoxDecoration(
                    color: backgroundImage.overlayColor
                        .withOpacity(backgroundImage.overlayIntensity),
                    image: backgroundImage.url != ''
                        ? getDecorationImage(backgroundImage)
                        : null,
                  )
                : null,
            padding: EdgeInsets.all(
                templateIsIn(note.templateId, [11, 12, 18, 17])
                    ? getRelativeHeight(20, constraints.maxWidth)
                    : 0),
            child: note.templateId == 1
                ? note.textComponents.first.isEmpty
                    ? isOutline
                        ? const TextColumnPreview()
                        : Container()
                    : TextColumnDisplay(
                        textComponents: note.textComponents.first,
                        templateId: note.templateId,
                      )
                : FractionallySizedBox(
                    widthFactor: 0.85,
                    heightFactor: 0.85,
                    child: Center(
                      child: note.templateId == 2
                          ? AspectRatio(
                              aspectRatio: 1,
                              child: isOutline &&
                                      (note.imageComponents.isEmpty ||
                                          note.imageComponents[0].url == '')
                                  ? Container(
                                      color: Colors.grey[400],
                                    )
                                  : ImageDisplay(
                                      imageComponent:
                                          note.imageComponents.first,
                                      borderRadius: 10
                                      // imageIndex: 0,
                                      ),
                            )
                          : isOutline &&
                                  (note.imageComponents.isEmpty ||
                                      note.imageComponents[0].url == '')
                              ? Container(
                                  color: Colors.grey[400],
                                )
                              : ImageDisplay(
                                  imageComponent: note.imageComponents.first,
                                  borderRadius: 10,
                                  // imageIndex: 0,
                                ),
                    ),
                  )),
      );
    });
  }
}
