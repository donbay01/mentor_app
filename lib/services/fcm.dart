import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  static var messaging = FirebaseMessaging.instance;
  static var auth = AuthService();

  static var plugin = FlutterLocalNotificationsPlugin();

  static listen() {
    FirebaseMessaging.onMessage.listen(
      (event) => showLocal(
        title: event.notification!.title!,
        body: event.notification!.body!,
      ),
    );
  }

  static Future<String?> _getToken() async {
    await messaging.requestPermission();
    return messaging.getToken();
  }

  static updateToken(String role) async {
    var token = await _getToken();
    if (role == MENTOR) {
      await messaging.subscribeToTopic('monthlyReminder');
    }

    return auth.updateField({'token': token});
  }

  static void onDidReceiveNotificationResponse(NotificationResponse res) async {
    final String? payload = res.payload;
    if (res.payload != null) {}
  }

  static initLocalMessaging() async {
    const android = AndroidInitializationSettings('app_icon');
    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    final initializationSettings = InitializationSettings(
      android: android,
      iOS: initializationSettingsDarwin,
    );
    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static showLocal({
    required String title,
    required String body,
  }) {
    const androidNotificationDetails = AndroidNotificationDetails(
      'career_paddy',
      'local',
      channelDescription: 'local notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      enableVibration: true,
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(
        presentSound: true,
      ),
    );

    return plugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
