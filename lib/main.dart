import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/bindings/root_bindings.dart';
import 'package:recipy/presentation/pages/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _setUpStripe();
  runApp(const MyApp());
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
    );
  }
}

//Notification
//Like Functionality

//Functionality can be added
//1)Profile Pic In Edit Screen,
//2)Search Functionality In HomeScreen, *
//3)Share Recipe with Friends And Family
//4)All Data Correction Of Recipe
