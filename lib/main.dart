import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:recipy/bindings/root_bindings.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/ui/auth/splash_screen.dart';

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
//Share Recipe with Friends And Family
//Search , Explore In HomeScreen
//All Data Correction Of Recipe
//In Any Login ,Favourite Remain The Same
//Folder Structure //working , service structure, firebase
//Image Getting Cropped In Profile Pic
//Profile Pic In Edit Screen,
//Update Data after when came back to the setting screen from edit screen //done
//cooking screen static data
