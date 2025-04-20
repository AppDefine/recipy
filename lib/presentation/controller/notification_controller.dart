import 'dart:convert'; // For JSON encoding and decoding
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:recipy/core/constants/constants.dart';

class NotificationController extends GetxController {
  RxList<String> notifications = <String>[].obs;
  static const int maxNotifications = 10;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications(); // Load notifications on initialization
  }

  // Add a new notification
  void addNotification(String message) {
    if (notifications.length >= maxNotifications) {
      notifications.removeAt(0); // Remove the oldest notification
    }
    notifications.add(message);
    _saveNotifications(); // Save the entire list
  }

  // Save the list of notifications to secure storage
  Future<void> _saveNotifications() async {
    final pref = Constants.securePreferences();
    final encodedNotifications = jsonEncode(notifications); // Serialize the list to JSON
    await pref.write(
      key: Constants.notificationList,
      value: encodedNotifications,
    );
  }

  // Load notifications from secure storage
  Future<void> _loadNotifications() async {
    final pref = Constants.securePreferences();
    final storedData = await pref.read(key: Constants.notificationList);
    if (storedData != null) {
      final decodedNotifications = jsonDecode(storedData) as List<dynamic>; // Deserialize JSON
      notifications.value = decodedNotifications.cast<String>(); // Cast to List<String>
    }
  }
}
