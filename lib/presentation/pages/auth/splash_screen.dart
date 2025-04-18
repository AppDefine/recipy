import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/pages/dashboard_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Future.delayed(const Duration(seconds: 4), _navigate);
  }

  Future<void> _navigate() async {
    final pref = Constants.securePreferences();
    final isLogin = await pref.read(key: Constants.isLogin);
    Get.offAll(() => isLogin == true.toString() ? DashboardScreen() : LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/splash_animation.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              Constants.appName,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
