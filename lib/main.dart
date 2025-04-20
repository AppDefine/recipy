import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/bindings/root_bindings.dart';
import 'package:recipy/presentation/controller/notification_controller.dart';
import 'package:recipy/presentation/pages/auth/splash_screen.dart';
import 'package:recipy/presentation/pages/notification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationController controller = Get.put((NotificationController()));

  // // Get FCM token
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print("FCM Token: $fcmToken");

  // Subscribe to topic
  const topicName = "recipy"; // Replace with your topic name
  await FirebaseMessaging.instance.subscribeToTopic(topicName);
  print("Subscribed to topic: $topicName");


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      controller.addNotification(
        message.notification!.title ?? 'No Title',
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      final title = message.notification!.title ?? 'No Title';
      if (!controller.notifications.contains(title)) {
        controller.addNotification(title);
      }
    }
  });

  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null && initialMessage.notification != null) {
    controller.addNotification(initialMessage.notification!.title ?? 'No Title');
  }

  await _setUpStripe();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    final prefs = Constants.securePreferences();
    final storedData = await prefs.read(key: Constants.notificationList);
    List<String> notifications = [];

    if (storedData != null) {
      final decodedNotifications = jsonDecode(storedData) as List<dynamic>;
      notifications = decodedNotifications.cast<String>();
    }

    // Prevent duplicate notification
    const maxNotifications = 10;
    final title = message.notification!.title ?? 'No Title';
    if (!notifications.contains(title)) {
      if (notifications.length >= maxNotifications) {
        notifications.removeAt(0); // Remove the oldest notification
      }
      notifications.add(title);
      await prefs.write(
        key: Constants.notificationList,
        value: jsonEncode(notifications),
      );
    }
  }
}


Future<void> _setUpStripe() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.stripePublishableKey;
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      initialBinding: RootBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
      routes: {
        '/notifications': (context) => NotificationScreen(),
      },
    );
  }
}

//Notification
