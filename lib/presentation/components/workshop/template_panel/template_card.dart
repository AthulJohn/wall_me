import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/bloc/singlenote/singlenote_bloc.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({super.key, required this.templateIndex});
  final int templateIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        child: Image.asset(
          "assets/images/components/T1$templateIndex.png",
        ),
        onTap: () {
          BlocProvider.of<NotesBloc>(context).add(SetTemplate(
              templateIndex: 10 + templateIndex,
              singlenoteBloc: BlocProvider.of<SinglenoteBloc>(context)));
        },
      ),
    );
  }
}
