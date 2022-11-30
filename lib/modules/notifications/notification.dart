import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    _fcm.getToken().then((token) {
      debugPrint('our token is: $token');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notification Screen.'),
      ),
    );
  }
}
