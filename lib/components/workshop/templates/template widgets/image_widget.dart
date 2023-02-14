import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_me/models/workshop/image_component_model.dart';

import '../../../../bloc/notes/notes_bloc.dart';

class ImageWidget extends StatelessWidget {
  final ImageComponent? imageComponent;
  const ImageWidget({super.key, this.imageComponent});

  @override
  Widget build(BuildContext context) {
    return imageComponent == null
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  BlocProvider.of<NotesBloc>(context).add(AddImage());
                },
              ),
            ))
        : Image.network(
            imageComponent!.url,
            fit: BoxFit.cover,
          );
  }
}
