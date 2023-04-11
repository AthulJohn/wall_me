import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';
import 'package:wall_me/presentation/components/workshop/templates/template_displays/template_0_display.dart';

import '../../logic/bloc/notes/notes_bloc.dart';
import '../../logic/bloc/site_data/sitedata_cubit.dart';
import '../components/workshop/templates/template_displays/template_1_display.dart';
import '../components/workshop/templates/template_displays/template_2_display.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, this.siteUrl});
  final String? siteUrl;

  Widget chooseTemplate(int templateId, SingleNote note) {
    switch ((templateId / 10).floor()) {
      case 0:
        return ViewTemplate0(note: note);
      case 1:
        return ViewTemplate1(note: note);
      case 2:
        return ViewTemplate2(note: note);
      case 3:
      // return  ViewTemplate3(note:note);
      default:
        return ViewTemplate1(note: note);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<SingleNote> notes =
        BlocProvider.of<NotesBloc>(context).state.notes;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: notes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      for (SingleNote note in notes)
                        if (note.templateId != -1)
                          AspectRatio(
                            aspectRatio: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height,
                            child: chooseTemplate(
                              note.templateId,
                              note,
                            ),
                          ),
                    ],
                  )),
      ),
    );
  }
}
