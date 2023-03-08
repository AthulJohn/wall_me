import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/constants/global_variables.dart';

import '../../../../constants/color_pallette.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import 'template_set.dart';

class TemplatesPanel extends StatelessWidget {
  const TemplatesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
        color: Colors.white,
        duration: const Duration(milliseconds: 100),
        width: state.isTemplatesOpen ? max(180, getWidth(context) * 0.2) : 1,
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
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Templates Panel",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
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
