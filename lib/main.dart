import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/bindings/root_bindings.dart';
import 'package:recipy/presentation/controller/notification_controller.dart';
import 'package:recipy/presentation/pages/auth/splash_screen.dart';
import 'package:recipy/presentation/pages/notification/notification_details_screen.dart';
import 'package:recipy/presentation/pages/notification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize NotificationController
  final NotificationController controller = Get.put(NotificationController());

  // Subscribe to topic
  const topicName = "recipy"; // Replace with your topic name
  await FirebaseMessaging.instance.subscribeToTopic(topicName);
  print("Subscribed to topic: $topicName");

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      controller.addNotification(
        title: message.notification!.title ?? 'No Title',
        text: message.notification!.body ?? 'No Content',
      );
    }
  });

  // Handle notification taps (app opened from a notification)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      final title = message.notification!.title ?? 'No Title';
      final text = message.notification!.body ?? 'No Content';
      controller.addNotification(title: title, text: text);
    }
  });

  // Handle app startup from a notification
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null && initialMessage.notification != null) {
    controller.addNotification(
      title: initialMessage.notification!.title ?? 'No Title',
      text: initialMessage.notification!.body ?? 'No Content',
    );
  }

  // Set up Stripe
  await _setUpStripe();

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    final prefs = Constants.securePreferences();
    final storedData = await prefs.read(key: Constants.notificationList);

    List<Map<String, String>> notifications = [];
    if (storedData != null) {
      final decodedNotifications = jsonDecode(storedData) as List<dynamic>;
      notifications = decodedNotifications.cast<Map<String, String>>();
    }

    const maxNotifications = 10;
    final title = message.notification!.title ?? 'No Title';
    final text = message.notification!.body ?? 'No Content';

    if (!notifications.any((notif) => notif['title'] == title)) {
      if (notifications.length >= maxNotifications) {
        notifications.removeAt(0);
      }
      notifications.add({'title': title, 'text': text});
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
      getPages: [
        GetPage(name: '/notifications', page: () => NotificationScreen()),
        GetPage(
          name: '/notification-details',
          page: () {
            final args = Get.arguments as Map<String, String>;
            return NotificationDetailsScreen(
              title: args['title'] ?? 'No Title',
              text: args['text'] ?? 'No Content',
            );
          },
        ),
      ],
    );
  }
}
