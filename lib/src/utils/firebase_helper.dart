import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseHelper {
  static final FirebaseHelper _singleton = FirebaseHelper._internal();

  factory FirebaseHelper() {
    return _singleton;
  }

  FirebaseHelper._internal();

  initialize() async {
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    playSound: true,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }

  Future<void> display(RemoteMessage message,
      {String? title, String? body}) async {
    try {
      if (message.notification == null && title == null) {
        return;
      }

      ///creating a unique integer id based on present realtime
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      ///notification dispatch_summery is the MOST important criteria to set channel in flutter_local_notifications
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "dkakeen_sale_ref", //channel ID
            "Sale ref", //channel NAME
            icon: '@drawable/ic_notification', //channel DESCRIPTION
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
        ),
      );

      ///function to display heads up notification
      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification != null ? message.notification!.title : title!,
        message.notification != null ? message.notification!.body : body!,
        notificationDetails,
        payload: "${message.data}",
      );
    } on Exception catch (e) {
      print("Foreground channel error $e");
    }
  }
}
