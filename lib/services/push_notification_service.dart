// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class PushNotificationService {
//   Future initialize() async {
//     debugPrint('firebase initialized');
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('Got a message whilst in the foreground!');
//       debugPrint('Message data: ${message.data}');

//       if (message.notification != null) {
//         debugPrint(
//             'Message also contained a notification: ${message.notification!.title}');
//       }
//     });

//     //FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   }

//   Future<void> backgroundHandler(RemoteMessage message) async {
//     debugPrint('Handling a background message ${message.messageId}');
//   }
// }
