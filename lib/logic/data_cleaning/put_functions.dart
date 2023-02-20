import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wall_me/data%20layer/firebase_functions.dart';
import 'package:wall_me/logic/models/workshop/text_component_model.dart';

import '../models/workshop/image_component_model.dart';
import '../models/workshop/singlenote_model.dart';

class SendFunctions {
  static Future<bool> sendSiteCleanData(
      String url, List<SingleNote> notes) async {
    if (notes.isEmpty) {
      print("notes empty");
      return false;
    }
    List<Map<String, dynamic>> notesList = [];
    for (SingleNote note in notes) {
      List<Map<String, dynamic>> textComponents = [];
      for (List<TextComponent> textColumn in note.textComponents) {
        List<Map<String, dynamic>> textList = [];
        for (TextComponent text in textColumn) {
          textList.add({
            "text": text.text,
            "size": text.fontSize,
            "fontFamily": text.fontFamily,
            "align": text.textAlign == TextAlign.left
                ? 0
                : text.textAlign == TextAlign.center
                    ? 1
                    : 2,
            "isBold": text.isBold,
            "isItalic": text.isItalic,
            "isUnderlined": text.isUnderlined,
            "color": text.fontColor.value,
          });
        }
        textComponents.add({"singleTexts": textList});
      }

      List<Map<String, dynamic>> images = [];
      for (ImageComponent image in note.imageComponents) {
        images.add({
          "url": image.url,
          "fit": image.fit == BoxFit.contain
              ? 0
              : image.fit == BoxFit.cover
                  ? 1
                  : 2,
          "overlayColor":
              image.overlayColor.withOpacity(image.overlayIntensity).value,
        });
      }
      notesList.add({
        "images": images,
        "texts": textComponents,
        "noteId": note.noteid,
        "templateId": note.templateId
      });
    }
    try {
      return await FirebaseFunctions.addNote(url, notesList);
    } catch (e) {
      // print(e);
      return false;
    }
  }
}
