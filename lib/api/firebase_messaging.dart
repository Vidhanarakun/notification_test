import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class FirebaseMessagingAPI{
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async{
    await _firebaseMessaging.requestPermission();
    final _fCMToken =await _firebaseMessaging.getToken();
    print('Token: $_fCMToken');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print("Handling a background message: ${message.messageId}");
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}