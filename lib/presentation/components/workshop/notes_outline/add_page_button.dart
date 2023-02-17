import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../color_pallette.dart';
import '../../../../logic/bloc/notes/notes_bloc.dart';

class AddPageButton extends StatelessWidget {
  const AddPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: InkWell(
        onTap: () {
          BlocProvider.of<NotesBloc>(context).add(AddNotes(templateIndex: -1));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Container(
              decoration: BoxDecoration(
                  color: CustomColor.secondaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.add,
                color: CustomColor.tertiaryColor,
                size: 30,
              )),
        ),
      ),
    );
  }
}
