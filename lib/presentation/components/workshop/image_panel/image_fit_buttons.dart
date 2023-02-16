import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/models/workshop/image_component_model.dart';

class ImageFitButton extends StatelessWidget {
  const ImageFitButton({super.key, required this.fit});
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return state.currentImage == null
            ? Container()
            : Expanded(
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<NotesBloc>(context).add(ChangeImageStyle(
                        (state.currentImage ?? ImageComponent())
                            .copyWith(fit: fit)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: state.currentImage!.fit == fit
                            ? Colors.pink
                            : Colors.white,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        fit == BoxFit.contain
                            ? Icons.abc
                            : fit == BoxFit.cover
                                ? Icons.g_translate_rounded
                                : Icons.image,
                        color: state.currentImage!.fit == fit
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class ImageCoverButton extends StatelessWidget {
  const ImageCoverButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageFitButton(fit: BoxFit.cover);
  }
}

class ImageContainButton extends StatelessWidget {
  const ImageContainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageFitButton(fit: BoxFit.contain);
  }
}

class ImageFillButton extends StatelessWidget {
  const ImageFillButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageFitButton(fit: BoxFit.fill);
  }
}
