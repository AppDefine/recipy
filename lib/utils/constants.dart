
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const kBackgroundColor = Color(0xffeff1f7);
const kPrimaryColor = Color(0xff568A9F);
const kBannerColor = Color(0xff579f8c);

class Constants {
  static const appName = "Recipy";
  static const uid = "uid";
  static const email = "email";
  static const name = "name";
  static const isLogin = "isLogin";

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
}