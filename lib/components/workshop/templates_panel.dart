import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';

import '../../bloc/workshop_ui/workshop_ui_cubit.dart';

class TemplatesPanel extends StatelessWidget {
  const TemplatesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width:
              state.isTemplatesOpen ? max(180, getWidth(context) * 0.25) : 15,
          child: Row(children: [
            Center(
              child: Container(
                color: Colors.indigo,
                width: 15,
                height: 40,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      context.read<WorkshopUiCubit>().toggleTemplates();
                    },
                    child: state.isTemplatesOpen
                        ? Icon(
                            Icons.keyboard_arrow_right,
                            size: 15,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.keyboard_arrow_left,
                            size: 15,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),
            state.isTemplatesOpen
                ? Expanded(
                    child: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [Text("Hello")],
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                    color: Colors.red,
                    height: 50,
                  ))
          ]));
    });
  }
}
