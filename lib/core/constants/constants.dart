
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

const kBackgroundColor = Color(0xffeff1f7);
const kPrimaryColor = Color(0xff568A9F);
const kBannerColor = Color(0xff579f8c);

class Constants {
  static const appName = "Recipy";
  static const uid = "uid";
  static const email = "email";
  static const phoneNumber = "phoneNumber";
  static const profilePic = "profilePic";
  static const name = "name";
  static const isLogin = "isLogin";
  static const isNotificationPermission = "isNotificationPermission";

  static const stripePublishableKey = "pk_test_51BTUDGJAJfZb9HEBwDg86TN1KNprHjkfipXmEDMb0gSCassK5T3ZfxsAbcgKVmAIXF7oZ6ItlZZbXO6idTHE67IM007EwQ4uN3";
  static const stripeSecretKey = "sk_test_tR3PYbcVNZZ796tH88S4VQ2u";

  static FlutterSecureStorage securePreferences() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    IOSOptions getIOSOptions() =>
        const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    return FlutterSecureStorage(
        aOptions: getAndroidOptions(), iOptions: getIOSOptions());
  }

  static showSnackBar(String message, Color color) {
    Get.rawSnackbar(
      message: message,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      padding: const EdgeInsets.all(15),
    );
  }

}
class IndianMobileNumberFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^[6-9]\d{0,9}$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty || _regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}