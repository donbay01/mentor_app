import 'package:file_picker/file_picker.dart';
import 'dart:io' show File;

class Picker {
  static var picker = FilePicker.platform;

  static Future<File?> pickImage() async {
    FilePickerResult? result = await picker.pickFiles(
      type: FileType.image,
    );
    File? file;

    if (result != null) {
      file = File(result.files.single.path!);
    }

    return file;
  }

  static Future<File?> pickFile() async {
    FilePickerResult? result = await picker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'docx'],
    );
    File? file;

    if (result != null) {
      file = File(result.files.single.path!);
    }

    return file;
  }
}
