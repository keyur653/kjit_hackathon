import 'package:attendance_app/main.dart';
import 'package:attendance_app/pages/classes_2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fCMToken');
  }

  void handleMessage(RemoteMessage? message) {
    if (message != null) {
      print('From: ${message.from}');
      print('Notification: ${message.notification?.body ?? ''}');
    }
    navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (context) => SubjectListScreen2()),
  );
  }
}
