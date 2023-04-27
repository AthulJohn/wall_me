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
class ViewTemplate3 extends StatelessWidget {
  /// Requires 1 image and 1 text component
  /// 2nd image is optional to be background image :- future implementation

  final SingleNote note;
  final bool isOutline;
  const ViewTemplate3({super.key, required this.note, this.isOutline = false});

  bool templateIsIn(SingleNote not, List<int> templateId) {
    /// Checks if the current template is in the list of templates
    return templateId.contains(not.templateId);
  }

  Widget getImageCompnent(List<int> bordertemplates) {
    return isOutline &&
            (note.imageComponents.isEmpty ||
                note.imageComponents.first.url == "")
        ? Container(
            color: Colors.grey[400],
          )
        : ImageDisplay(
            imageComponent: note.imageComponents.isEmpty
                ? null
                : note.imageComponents.first,
            borderRadius: templateIsIn(note, bordertemplates) ? 10 : 0,
            // imageIndex: 0,
          );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: templateIsIn(note, [31, 33, 35]) ? 3 : 1,
                child: templateIsIn(
                        note, [31, 33, 35]) // If Top part contains image
                    ? FractionallySizedBox(
                        alignment: Alignment.bottomCenter,
                        widthFactor:
                            templateIsIn(note, [31, 32, 33, 34, 36]) ? 0.85 : 1,
                        heightFactor:
                            templateIsIn(note, [31, 32, 33, 34, 36]) ? 0.85 : 1,
                        child: note.templateId == 31
                            ? Center(
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: getImageCompnent([31, 33])))
                            : getImageCompnent([31, 33]),
                      )
                    : //Left Side has Text
                    note.textComponents.first.isEmpty
                        ? isOutline
                            ? const TextColumnPreview()
                            : Container()
                        : TextColumnDisplay(
                            alignment: Alignment.bottomCenter,
                            textComponents: note.textComponents.first,
                            templateId: note.templateId,
                          ),
              ),
              Expanded(
                flex: templateIsIn(note, [32, 34, 36]) ? 3 : 1,
                child: templateIsIn(
                        note, [32, 34, 36]) // If Bottom part has image
                    ? FractionallySizedBox(
                        alignment: Alignment.topCenter,
                        widthFactor:
                            templateIsIn(note, [31, 32, 33, 34, 35]) ? 0.85 : 1,
                        heightFactor:
                            templateIsIn(note, [31, 32, 33, 34, 35]) ? 0.85 : 1,
                        child: note.templateId == 32
                            ? Center(
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: getImageCompnent([32, 34])),
                              )
                            : getImageCompnent([32, 34]),
                      )
                    : note.textComponents.isEmpty ||
                            note.textComponents.first.isEmpty
                        ? isOutline
                            ? const TextColumnPreview()
                            : Container()
                        : TextColumnDisplay(
                            alignment: Alignment.topCenter,
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
