import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wall_me/data%20layer/firebase_functions.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import '../models/workshop/image_component_model.dart';
import '../models/workshop/singlenote_model.dart';

class FetchFunctions {
  static Future<Map<String, dynamic>> fetchSiteCleanData(String url) async {
    /*return a map with the following structure:
    {
      "data": List<SingleNote>?,
      "status": String
    }
    */
    Map<String, dynamic> rawResult =
        await FirebaseFunctions.firebaseGetSite(url);
    QuerySnapshot<Map<String, dynamic>>? rawData = rawResult['data'];

    if (rawData == null) return {'data': null, 'status': rawResult['status']};
    List<SingleNote>? notes = [];
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
                fontColor: Color(singleText['color'] ?? 0),
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
                mimeType: image["mime"],
                fit: image["fit"] == 0
                    ? BoxFit.contain
                    : image['fit'] == 1
                        ? BoxFit.cover
                        : BoxFit.fill,
                overlayColor: Color(image["overlayColor"] ?? 0),
                overlayIntensity: image["overlayIntensity"]));
          }
        }
        singNote.imageComponents = images;
        notes.add(singNote);
      }
    }
    return {'data': notes, 'status': rawResult['status']};
  }
}
