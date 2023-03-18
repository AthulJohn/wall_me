import 'package:image_picker/image_picker.dart';

class ImagePickerProvider {
  static ImagePicker picker = ImagePicker();

  static Future<XFile?> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}
