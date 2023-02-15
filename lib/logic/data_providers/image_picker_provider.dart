import 'package:image_picker/image_picker.dart';

class ImagePickerProvider {
  static ImagePicker picker = ImagePicker();

  static Future<String?> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return pickedFile.path;
  }
}
