import 'package:career_paddy/services/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static var messaging = FirebaseMessaging.instance;
  static var auth = AuthService();

  static Future<String?> _getToken() async {
    await messaging.requestPermission();
    return messaging.getToken();
  }

  static updateToken() async {
    var token = await _getToken();
    return auth.updateField({'token': token});
  }
}
