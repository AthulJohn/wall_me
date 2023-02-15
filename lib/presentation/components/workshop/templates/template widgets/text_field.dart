import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../../logic/bloc/textfield/textfield_cubit.dart';

class TextEnteringField extends StatelessWidget {
  const TextEnteringField({super.key, this.initText = ""});
  final String initText;

  @override
  Widget build(BuildContext context) {
    TextEditingController tec = TextEditingController(text: initText);
    return BlocBuilder<TextFieldCubit, TextFieldState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tec,
                  decoration: InputDecoration(
                      hintText: 'Enter some text',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  onChanged: (value) {
                    BlocProvider.of<TextFieldCubit>(context).changeText(value);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  BlocProvider.of<NotesBloc>(context).add(AddText(
                    state.text,
                  ));
                  tec.clear();
                },
              )
            ],
          ),
        );
      },
    );
  }
}