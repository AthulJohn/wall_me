// import 'dart:typed_data';

// import 'package:image_compression/image_compression.dart';

// class ImageCompressionProvider {
//   static Future<Uint8List> pickImage() async {
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
// }
