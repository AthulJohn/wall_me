// import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wall_me/constants/color_pallette.dart';
import 'dart:math';

import 'package:wall_me/global_functions.dart';
import 'package:wall_me/logic/models/workshop/image_component_model.dart';
import 'package:wall_me/presentation/components/workshop/buttons.dart';

import '../../../../constants/text_styles.dart';
// import '../../../../logic/bloc/notes/notes_bloc.dart';
import '../../../../logic/bloc/singlenote/singlenote_bloc.dart';
import '../../../../logic/bloc/workshop_ui/workshop_ui_cubit.dart';
import '../../../logic/bloc/notes/notes_bloc.dart';
import '../../../logic/bloc/site_data/sitedata_cubit.dart';
import '../../../logic/bloc/textfield/textfield_cubit.dart';

class PublishPanel extends StatelessWidget {
  const PublishPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopUiCubit, WorkshopUiState>(
        builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state.isPublishOpen)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<WorkshopUiCubit>(context).closePublishPanel();
                },
                child: Container(
                  color: Colors.black12,
                ),
              ),
            ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: state.isPublishOpen ? max(220, getWidth(context) * 0.4) : 0,
            child: const PublishPanelBody(),
          )
        ],
      );
    });
  }
}

class PublishPanelBody extends StatelessWidget {
  const PublishPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<SitedataCubit, SitedataState>(
            builder: (context, publishstate) {
          return ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Publish WebPoster",
                    style: CustomTextStyles.panelTitle,
                  )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[100]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topLeft,
                        child: Text('Custum Url')),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (val) {
                          context.read<TextFieldCubit>().changeText(val);
                        },
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                          text: 'Publish',
                          onPressed: () {
                            context.read<SitedataCubit>().publishNote(
                                BlocProvider.of<TextFieldCubit>(context)
                                    .state
                                    .textComponent
                                    .text,
                                BlocProvider.of<NotesBloc>(context)
                                    .state
                                    .notes);
                          },
                        )
                        // }),
                        )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (publishstate is ImageUploading)
                const Center(
                  child: Text('Uploading Images...'),
                )
              else if (publishstate is SitedataLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (publishstate is SitedataError)
                Text("Error: ${publishstate.errorText}")
              else if (publishstate is SiteSendSuccess)
                Column(
                  children: [
                    const Text(
                      "Your Web Poster is now available at",
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinkifyText(
                          publishstate.completeUrl,
                          textAlign: TextAlign.center,
                          linkStyle: const TextStyle(color: Colors.blue),
                          onTap: (link) {
                            launchUrl(Uri.tryParse(link.value ?? "") ??
                                Uri.parse(publishstate.completeUrl));
                          },
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text: publishstate.completeUrl));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Url copied to Clipboard!'),
                                backgroundColor: Colors.green[300],
                              ));
                            })
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              CustomElevatedButton(
                  onPressed: publishstate.completeUrl.isEmpty ? null : () {},
                  text: 'Share Url',
                  icon: Icons.share),
              const SizedBox(height: 10),
              CustomElevatedButton(
                  onPressed: publishstate.completeUrl.isEmpty ? null : () {},
                  text: "Generate QR Code",
                  icon: Icons.qr_code_2)
            ],
          );
        }));
  }
}
