import 'dart:convert'; // For JSON encoding and decoding
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipy/core/constants/constants.dart';

class NotificationItem {
  final String title;
  final String text;

  NotificationItem({required this.title, required this.text});

  Map<String, dynamic> toJson() => {
    'title': title,
    'text': text,
  };

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    title: json['title'],
    text: json['text'],
  );
}

class NotificationController extends GetxController {
  RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  static const int maxNotifications = 10;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications(); // Load notifications on initialization
  }

  // Add a new notification with named parameters
  void addNotification({required String title, required String text}) {
    if (!notifications.any((item) => item.title == title)) {
      if (notifications.length >= maxNotifications) {
        notifications.removeAt(0); // Remove the oldest notification
      }
      notifications.add(NotificationItem(title: title, text: text));
      _saveNotifications();
    }
  }

  Future<void> _saveNotifications() async {
    final pref = Constants.securePreferences();
    final encodedNotifications = jsonEncode(
      notifications.map((item) => item.toJson()).toList(),
    );
    await pref.write(
      key: Constants.notificationList,
      value: encodedNotifications,
    );
  }

  Future<void> _loadNotifications() async {
    final pref = Constants.securePreferences();
    final storedData = await pref.read(key: Constants.notificationList);
    if (storedData != null) {
      final decodedList = jsonDecode(storedData) as List<dynamic>;
      notifications.value = decodedList
          .map((item) => NotificationItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }
}
