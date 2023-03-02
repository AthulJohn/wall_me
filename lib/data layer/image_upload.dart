import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_compression/image_compression.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/services.dart' as root_services;

import '../logic/models/workshop/image_component_model.dart';

class ImageUploder {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static Future<String> uploadImage(
      String url, ImageComponent image, int noteIndex, int imageIndex) async {
    Uint8List bytes = await XFile(image.url).readAsBytes();
    // print(
    //     "Compressing Image $imageIndex of Size ${await XFile(image.url).length()}");
    // Uint8List compressedBytes = await _compressImage(bytes, image.url);
    var snapshot = await _storage
        .ref('site_files/$url/$noteIndex/$imageIndex')
        .putData(bytes, SettableMetadata(contentType: image.mimeType));

    var downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//   static Future<Uint8List> _compressImage(Uint8List bytes, String path) async {
//     final input = ImageFile(
//       rawBytes: bytes,
//       filePath: path,
//     );
//     final output = await compressInQueue(ImageFileConfiguration(
//         input: input,
//         config: const Configuration(
//           outputType: OutputType.png,
//           pngCompression: PngCompression.defaultCompression,
//         )));

//     print('Compressed to ${output.sizeInBytes}');
//     return output.rawBytes;
//   }
}
