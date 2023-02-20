import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';

import '../../logic/bloc/notes/notes_bloc.dart';
import '../../logic/bloc/site_data/sitedata_cubit.dart';
import '../components/workshop/templates/template_1_display.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, this.siteUrl});
  final String? siteUrl;

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
                            child: ViewTemplate1(
                              note: note,
                            ),
                          ),
                    ],
                  )),
      ),
    );
  }
}
