import 'dart:html' as html;
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/services.dart' as root_services;

import '../logic/models/workshop/image_component_model.dart';

class ImageUploder {
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static Future<String> uploadImage(
      String url, ImageComponent image, int noteIndex, int imageIndex) async {
    Uint8List bytes = await XFile(image.url).readAsBytes();
    var snapshot = await _storage
        .ref('site_files/$url/$noteIndex/$imageIndex')
        .putData(bytes, SettableMetadata(contentType: image.mimeType));

    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
