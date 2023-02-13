import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';

import '../../bloc/workshop_ui/workshop_ui_cubit.dart';

class PageOutline extends StatelessWidget {
  final bool isExpanded;
  const PageOutline({super.key, this.isExpanded = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: state.isOutlineOpen ? max(180, getWidth(context) * 0.15) : 0,
          child: state.isOutlineOpen
              ? Container(color: Colors.blue)
              : Container(color: Colors.yellow),
        );
      },
    );
  }
}
