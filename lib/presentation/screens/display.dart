import 'package:flutter/material.dart';
import 'package:wall_me/logic/models/workshop/singlenote_model.dart';

import '../components/workshop/templates/template_1_display.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen(this.notes, {super.key});
  final List<SingleNote> notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              for (SingleNote note in notes)
                AspectRatio(
                  aspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height,
                  child: ViewTemplate1(
                    note: note,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
