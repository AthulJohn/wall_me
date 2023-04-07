import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard(
      {super.key, required this.templateIndex, required this.templateSet});
  final int templateIndex, templateSet;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        child: Image.asset(
            templateSet == 0
                ? "assets/images/components/T$templateIndex.png"
                : "assets/images/components/T$templateSet$templateIndex.png",
            fit: BoxFit.fill),
        onTap: () {
          print("TemInd:${10 * templateSet + templateIndex} ");

          BlocProvider.of<NotesBloc>(context).add(SetTemplate(
              templateIndex: 10 * templateSet + templateIndex,
              singlenoteBloc: BlocProvider.of<SinglenoteBloc>(context)));
        },
      ),
    );
  }
}
