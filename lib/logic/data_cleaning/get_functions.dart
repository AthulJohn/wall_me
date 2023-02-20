import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wall_me/data%20layer/firebase_functions.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import '../models/workshop/image_component_model.dart';
import '../models/workshop/singlenote_model.dart';

class FetchFunctions {
  static Future<List<SingleNote>> fetchSiteCleanData(String url) async {
    QuerySnapshot<Map<String, dynamic>>? rawData =
        await FirebaseFunctions.firebaseGetSite(url);

    if (rawData == null) return [];
    print("rawData: ${rawData.docs.length}");
    List<SingleNote> notes = [];
    for (var note in rawData.docs) {
      {
        SingleNote singNote = SingleNote(
          noteid: note["noteId"],
          // backgroundColor: Color(note["backgroundColor"]),
          templateId: note["templateId"],
        );
        List<List<TextComponent>> textComponents = [];
        if (note["texts"] != null) {
          for (int i = 0; i < note["texts"].length; i++) {
            textComponents.add([]);
            for (var singleText in note["texts"][i]['singleTexts']) {
              textComponents[i].add(TextComponent(
                text: singleText['text'],
                fontSize: singleText['size'],
                // fontColor: Color((singleText['color']as String).)),
                fontFamily: singleText['fontFamily'],
                textAlign: singleText['align'] == 0
                    ? TextAlign.left
                    : singleText['align'] == 1
                        ? TextAlign.center
                        : TextAlign.right,
                isBold: singleText['isBold'],
                isItalic: singleText['isItalic'],
                isUnderlined: singleText['isUnderlined'],
              ));
            }
          }
        }
        singNote.textComponents = textComponents;

        List<ImageComponent> images = [];
        if (note["images"] != null) {
          for (dynamic image in note["images"]) {
            images.add(ImageComponent(
                url: image["url"],
                fit: image["fit"] == 0
                    ? BoxFit.contain
                    : image['fit'] == 1
                        ? BoxFit.cover
                        : BoxFit.fill,
                // overlayColor: image["overlayColor"],
                overlayIntensity: 0.4));
          }
        }
        singNote.imageComponents = images;
        notes.add(singNote);
      }
    }
    print("sending ${notes.length} notes");
    return notes;
  }
}
