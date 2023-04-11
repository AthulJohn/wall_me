//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/constants/global_variables.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/presentation/components/workshop/templates/template%20widgets/decoration_image_component.dart';

import '../../../../../global_functions.dart';
import '../../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../../logic/models/workshop/image_component_model.dart';
import '../../../../../logic/models/workshop/singlenote_model.dart';
import '../template widgets/image_widget.dart';
import '../template widgets/image_widget_display.dart';
import '../template widgets/text_column.dart';
import '../template widgets/text_column_display.dart';
import '../template widgets/text_column_preview.dart';

// Refer Template Varient Sheet for more details on how changes are done in the template
class ViewTemplate2 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation

  final SingleNote note;
  final bool isOutline;
  const ViewTemplate2({super.key, required this.note, this.isOutline = false});

  bool templateIsIn(SingleNote not, List<int> templateId) {
    /// Checks if the current template is in the list of templates
    return templateId.contains(not.templateId);
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: templateIsIn(
                        note, [21, 23, 24, 25]) // If Left Side contains image
                    ? FractionallySizedBox(
                        widthFactor: templateIsIn(note, [21, 24]) ? 0.85 : 1,
                        heightFactor: templateIsIn(note, [21, 24]) ? 0.85 : 1,
                        child: isOutline &&
                                (note.imageComponents.isEmpty ||
                                    note.imageComponents[0].url == '')
                            ? Container(
                                color: Colors.grey[400],
                              )
                            : ImageDisplay(
                                imageComponent: note.imageComponents.first,
                                borderRadius:
                                    templateIsIn(note, [21, 24]) ? 10 : 0,
                                // imageIndex: 0,
                              ),
                      )
                    : //Left Side has Text
                    note.textComponents.first.isEmpty
                        ? isOutline
                            ? const TextColumnPreview()
                            : Container()
                        : TextColumnDisplay(
                            textComponents: note.textComponents.first,
                            templateId: note.templateId,
                          ),
              ),
              Expanded(
                child: templateIsIn(
                        note, [21, 23, 24, 25]) // If Right Side has image
                    ? FractionallySizedBox(
                        widthFactor: templateIsIn(note, [21, 25]) ? 0.85 : 1,
                        heightFactor: templateIsIn(note, [21, 25]) ? 0.85 : 1,
                        child: isOutline &&
                                (note.imageComponents.length <= 1 ||
                                    note.imageComponents[1].url == '')
                            ? Container(
                                color: Colors.grey[400],
                              )
                            : ImageDisplay(
                                imageComponent: note.imageComponents.length > 1
                                    ? note.imageComponents[1]
                                    : null,
                                borderRadius:
                                    templateIsIn(note, [21, 25]) ? 10 : 0,
                                // imageIndex: 0,
                              ),
                      )
                    : note.textComponents.length <= 1 ||
                            note.textComponents[1].isEmpty
                        ? isOutline
                            ? const TextColumnPreview()
                            : Container()
                        : TextColumnDisplay(
                            textComponents: note.textComponents.length > 1
                                ? note.textComponents[1]
                                : [],
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
