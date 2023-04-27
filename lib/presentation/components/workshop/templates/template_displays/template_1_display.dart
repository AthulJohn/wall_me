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
class ViewTemplate1 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation
  final SingleNote note;
  final bool isOutline;
  const ViewTemplate1({super.key, required this.note, this.isOutline = false});

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
                      ? getDecorationImage(context, backgroundImage)
                      : null,
                )
              : null,
          padding: EdgeInsets.all(
              templateIsIn(note.templateId, [11, 12, 18, 17])
                  ? getRelativeHeight(20, constraints.maxWidth)
                  : 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: templateIsIn(note.templateId, [16, 18]) ? 3 : 1,
                child: templateIsIn(note.templateId,
                        [11, 13, 16, 17]) // If image is in the left side
                    ? FractionallySizedBox(
                        widthFactor:
                            templateIsIn(note.templateId, [11, 17]) ? 0.85 : 1,
                        heightFactor:
                            templateIsIn(note.templateId, [11, 17]) ? 0.85 : 1,
                        child: isOutline &&
                                (note.imageComponents.isEmpty ||
                                    note.imageComponents[0].url == '')
                            ? Container(
                                color: Colors.grey[400],
                              )
                            : ImageDisplay(
                                imageComponent: note.imageComponents.first,
                                borderRadius:
                                    templateIsIn(note.templateId, [11, 17])
                                        ? 10
                                        : 0,
                                // imageIndex: 0,
                              ),
                      )
                    : note.textComponents.first.isEmpty
                        ? isOutline
                            ? const TextColumnPreview()
                            : Container()
                        : TextColumnDisplay(
                            textComponents: note.textComponents.first,
                            templateId: note.templateId,
                          ),
              ),
              Expanded(
                flex: templateIsIn(note.templateId, [15, 17]) ? 3 : 1,
                child: templateIsIn(note.templateId,
                        [12, 14, 15, 18]) // If image is in the left side
                    ? FractionallySizedBox(
                        widthFactor:
                            templateIsIn(note.templateId, [12, 18]) ? 0.85 : 1,
                        heightFactor:
                            templateIsIn(note.templateId, [12, 18]) ? 0.85 : 1,
                        child: isOutline && note.imageComponents.isEmpty
                            ? Container(
                                color: Colors.grey[400],
                              )
                            : ImageDisplay(
                                imageComponent: note.imageComponents.isEmpty
                                    ? null
                                    : note.imageComponents.first,
                                borderRadius:
                                    templateIsIn(note.templateId, [12, 18])
                                        ? 10
                                        : 0,
                                // imageIndex: 0,
                              ),
                      )
                    : note.textComponents.first.isEmpty
                        ? isOutline
                            ? const TextColumnPreview()
                            : Container()
                        : TextColumnDisplay(
                            textComponents: note.textComponents.first,
                            templateId: note.templateId,
                          ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
