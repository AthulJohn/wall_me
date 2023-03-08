import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/color_pallette.dart';
import '../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';

class PanelCloseButton extends StatelessWidget {
  const PanelCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
              builder: (context, state) {
            return InkWell(
              onTap: () {
                if (state.isTemplatesOpen ||
                    state.isTextEditOpen ||
                    state.isImageEditOpen) {
                  context.read<WorkshopUiCubit>().closeActivePanel();
                } else {
                  context.read<WorkshopUiCubit>().openActivePanel();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(5),
                    ),
                    color: CustomColor.tertiaryColor),
                width: 15,
                height: 60,
                child: Center(
                  child: state.isTemplatesOpen ||
                          state.isTextEditOpen ||
                          state.isImageEditOpen
                      ? const Icon(
                          Icons.keyboard_arrow_right,
                          size: 15,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_left,
                          size: 15,
                          color: Colors.white,
                        ),
                ),
              ),
            );
          }),
        ),
        Container(
          color: CustomColor.tertiaryColor,
          width: 2,
        )
      ],
    );
  }
}
