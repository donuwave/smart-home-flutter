import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

typedef OnMessageCallback = void Function(RemoteMessage message);
typedef OnBackgroundMessageCallback =
    Future<void> Function(RemoteMessage message);

class FirebaseMessagingWidget extends StatefulWidget {
  final Widget child;
  final OnMessageCallback? onMessage;
  final OnMessageCallback? onMessageOpenedApp;
  final OnBackgroundMessageCallback? onBackgroundMessage;

  const FirebaseMessagingWidget({
    Key? key,
    required this.child,
    this.onMessage,
    this.onMessageOpenedApp,
    this.onBackgroundMessage,
  }) : super(key: key);

  @override
  _FirebaseMessagingWidgetState createState() =>
      _FirebaseMessagingWidgetState();
}

class _FirebaseMessagingWidgetState extends State<FirebaseMessagingWidget> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    _initializeFCM();
  }

  Future<void> _initializeFCM() async {
    if (widget.onBackgroundMessage != null) {
      FirebaseMessaging.onBackgroundMessage(widget.onBackgroundMessage!);
    }

    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    fcmToken = await _messaging.getToken();
    debugPrint('🔑 FCM Token: \$fcmToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (widget.onMessage != null) {
        widget.onMessage!(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (widget.onMessageOpenedApp != null) {
        widget.onMessageOpenedApp!(message);
      }
    });

    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null && widget.onMessageOpenedApp != null) {
      widget.onMessageOpenedApp!(initialMessage);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
