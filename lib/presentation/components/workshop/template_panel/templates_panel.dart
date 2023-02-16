import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/global_variables.dart';
import 'package:wall_me/presentation/components/workshop/template_panel/template_card.dart';

import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../close_button.dart';
import 'template_set.dart';

class TemplatesPanel extends StatelessWidget {
  const TemplatesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: state.isTemplatesOpen ? max(180, getWidth(context) * 0.25) : 1,
        child: const TemplatesPanelBody(),
      );
    });
  }
}

class TemplatesPanelBody extends StatelessWidget {
  const TemplatesPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Templates Panel"),
          ),
          for (int i = 0; i < templateSetSizes.length; i++)
            Column(
              children: [TemplateSet(id: i), const Divider()],
            )
        ],
      ),
    );
  }
}
