import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wall_me/constants/routes.dart';
import 'package:wall_me/logic/bloc/notes/notes_bloc.dart';
import 'package:wall_me/logic/bloc/site_data/sitedata_cubit.dart';

import '../../logic/bloc/textfield/textfield_cubit.dart';

class SelectUrlScreen extends StatelessWidget {
  const SelectUrlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Url'),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  context.go(homeRoute);
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: Center(child: BlocBuilder<TextFieldCubit, TextFieldState>(
            builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40,
                  child: TextField(
                    onChanged: (val) {
                      context.read<TextFieldCubit>().changeText(val);
                    },
                  ),
                ),

                BlocBuilder<SitedataCubit, SitedataState>(
                    builder: (context, publishstate) {
                  if (publishstate is ImageUploading) {
                    return const Center(
                      child: Text('Uploading Images'),
                    );
                  } else if (publishstate is SitedataLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (publishstate is SitedataError) {
                    return Text("Error: ${publishstate.errorText}");
                  } else if (publishstate is SiteSendSuccess) {
                    return LinkifyText(
                      "Your Web Poster is now available at https://wallme.web.app/${publishstate.siteUrl}",
                      textAlign: TextAlign.center,
                      linkStyle: TextStyle(color: Colors.blue),
                      onTap: (link) {
                        launchUrl(Uri.tryParse(link.value ?? "") ??
                            Uri.parse(
                                "https://wallme.web.app/${publishstate.siteUrl}"));
                      },
                    );
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
