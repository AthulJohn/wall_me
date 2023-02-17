import 'package:flutter/material.dart';
import 'package:wall_me/constants/global_variables.dart';

import '../../../../constants/color_pallette.dart';
import 'template_card.dart';

class TemplateSet extends StatelessWidget {
  const TemplateSet({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Template ${id + 1}',
            style: TextStyle(fontSize: 15, color: CustomColor.darkblue),
          ),
        ),
        for (int i = 1; i < templateSetSizes[id] + 1; i += 2)
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TemplateCard(templateIndex: i),
                ),
              ),
              if (i + 1 < templateSetSizes[id] + 1)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TemplateCard(templateIndex: i + 1),
                  ),
                ),
            ],
          )
      ],
    );
  }
}
