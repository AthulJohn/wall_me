import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/logic/bloc/site_data/sitedata_cubit.dart';

import '../../logic/bloc/textfield/textfield_cubit.dart';

class SelectUrlScreen extends StatelessWidget {
  const SelectUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:
        BlocBuilder<TextFieldCubit, TextFieldState>(builder: (context, state) {
      return Row(children: [
        Expanded(
          child: TextField(
            onChanged: (val) {
              context.read<TextFieldCubit>().changeText(val);
            },
          ),
        ),

        BlocBuilder<SitedataCubit, SitedataState>(
            builder: (context, publishstate) {
          if (publishstate is SitedataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (publishstate is SitedataError) {
            return const Text("Some error happended");
          } else if (publishstate is SitedataSuccess) {
            return const Text("Success");
          } else {
            return TextButton(
              child: const Text('Publish'),
              onPressed: () {
                context.read<SitedataCubit>().publishNote(
                    state.textComponent.text,
                    BlocProvider.of<NotesBloc>(context).state.notes);
              },
            );
          }
        })
        //   ],
        // ),
        //) ;
        //}),), //),
      ]);
    })));
  }
}
