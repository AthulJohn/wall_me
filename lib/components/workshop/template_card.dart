import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/notes/notes_bloc.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({super.key, required this.templateIndex});
  final int templateIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(
        "assets/images/components/Template_$templateIndex.png",
      ),
      onTap: () {
        BlocProvider.of<NotesBloc>(context).add(AddNotes());
      },
    );
  }
}