import 'package:flutter/material.dart';

class TextColumnPreview extends StatelessWidget {
// A placeholder for the text column widget

  const TextColumnPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 2,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(3)),
        ),
        Container(
          height: 2,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(3)),
          margin: const EdgeInsets.symmetric(horizontal: 15),
        ),
        Container(
          height: 2,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(3)),
          margin: const EdgeInsets.symmetric(horizontal: 6),
        )
      ],
    );
  }
}
