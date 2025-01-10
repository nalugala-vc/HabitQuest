import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:solutech/notifications/mobile/notifications_page.dart';

class FirebaseApi {
  //create an instance of Firebase Messaging
  static final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
  static Future<void> initNotifications() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    print('Token $fCMToken');

    //initialize further settings for push noti
    initPushNotifications();
  }

  //function to handle received messages
  static void handleMessage(RemoteMessage? message) {
    //if mesage is null, do nothing
    if (message == null) return;
    //navigate to new screen when message is received and user taps on it
    Get.to(() => NotificationsPage(), arguments: {
      'title': 'New Notification',
      'message': 'You have a new message!',
    });
  }

  //function to initialize background settings
  static Future initPushNotifications() async {
    //handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attatch event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
