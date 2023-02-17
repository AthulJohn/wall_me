import 'package:flutter/material.dart';

class NonSelectedTemplateOutline extends StatelessWidget {
  const NonSelectedTemplateOutline({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.question_mark,
            color: Colors.white,
            size: 30,
          )),
    );
    ;
  }
}
