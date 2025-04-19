import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/controller/notification_controller.dart';
import 'package:animate_do/animate_do.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.find<NotificationController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: Obx(
            () => controller.notifications.isEmpty
            ? _buildEmptyState()
            : _buildNotificationList(controller),
      ),
    );
  }

  // Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 80,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No notifications yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "We'll let you know when something new arrives!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Notification list widget
  Widget _buildNotificationList(NotificationController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.notifications.length,
      itemBuilder: (context, index) {
        final notification = controller.notifications[index];
        return FadeInUp(
          duration: Duration(milliseconds: 300 + (index * 100)),
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.withOpacity(0.1),
                child: const Icon(
                  Icons.notifications,
                  color: kPrimaryColor,
                ),
              ),
              title: Text(
                notification,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              // trailing: Icon(
              //   Icons.arrow_forward_ios,
              //   size: 16,
              //   color: Colors.grey[400],
              // ),
              onTap: () {
                // Get.snackbar(
                //   notification,
                //   "You tapped on this notification",
                //   snackPosition: SnackPosition.BOTTOM,
                // );
              },
            ),
          ),
        );
      },
    );
  }
}
