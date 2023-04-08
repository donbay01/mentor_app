import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' show File;

class UploadService {
  static final storage = FirebaseStorage.instance;

  static UploadTask upload(String path, File file) =>
      storage.ref().child(path).putFile(file);

  static Future<String> getUrl(UploadTask task) =>
      task.snapshot.ref.getDownloadURL();
}
