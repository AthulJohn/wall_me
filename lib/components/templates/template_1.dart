//Template 1 :- Column of Texts and an Image aligned horizontally

import 'package:flutter/material.dart';
import 'package:wall_me/models/workshop/text_component_model.dart';

import '../../models/workshop/singleNote_model.dart';

// Refer Template Varient Sheet for more details on how changes are done in the template
class Template1 extends StatelessWidget {
  const Template1({
    super.key,
    required this.note,
  });
  final SingleNote note;

  @override
  Widget build(BuildContext context) {
    print(note.templateId);
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: (note.templateId == 16 || note.templateId == 18) ? 3 : 1,
            child: [11, 13, 16, 17]
                    .contains(note.templateId) // If image is in the left side
                ? FractionallySizedBox(
                    widthFactor: note.templateId == 11 || note.templateId == 17
                        ? 0.75
                        : 1,
                    heightFactor: note.templateId == 11 || note.templateId == 17
                        ? 0.75
                        : 1,
                    child: Image.network(
                      note.imageComponents.first.url,
                      fit: BoxFit.cover,
                    ))
                : note.textComponents.isNotEmpty
                    ? Column(children: [
                        for (TextComponent tc in note.textComponents.first)
                          Text(tc.text,
                              style: TextStyle(
                                  fontSize: tc.fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: tc.fontColor)),
                      ])
                    : Container(),
          ),
          Expanded(
            flex: (note.templateId == 15 || note.templateId == 17) ? 3 : 1,
            child: [12, 14, 15, 18]
                    .contains(note.templateId) // If image is in the left side
                ? FractionallySizedBox(
                    widthFactor: note.templateId == 12 || note.templateId == 18
                        ? 0.75
                        : 1,
                    heightFactor: note.templateId == 12 || note.templateId == 18
                        ? 0.75
                        : 1,
                    child: Image.network(
                      note.imageComponents.first.url,
                      fit: BoxFit.cover,
                    ))
                : note.textComponents.isNotEmpty
                    ? Column(children: [
                        for (TextComponent tc in note.textComponents.first)
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
  }
}
