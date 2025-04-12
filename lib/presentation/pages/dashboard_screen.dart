import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/pages/favourite/favourite_screen.dart';
import 'package:recipy/presentation/pages/home/home_screen.dart';
import 'package:recipy/presentation/pages/meal_plan/meal_plan_screen.dart';
import 'package:recipy/presentation/pages/setting/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int selectedIndex = 0;

  late final List<Widget> page;

  @override
  void initState() {
    page = [
      HomeScreen(),
      FavouriteScreen(),
      MealPlanScreen(),
      SettingScreen(),
    ];
    checkAndRequestPermission();
    super.initState();
  }

  checkAndRequestPermission() async {
    final pref = Constants.securePreferences();
      String hasRequestedPermission = await pref.read(key:Constants.isNotificationPermission) ?? "";
      if (hasRequestedPermission!="true") {
        await _requestNotificationPermission();
        await pref.write(key: Constants.isNotificationPermission, value: "true");
      }
  }

  Future<void> _requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission for notifications.");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provisional permission for notifications.");
    } else {
      print("User declined or has not yet responded to notification permission request.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconSize: 28,
            currentIndex: selectedIndex,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
            onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),label: "Home"),
              BottomNavigationBarItem(icon: Icon(selectedIndex == 1 ? Icons.favorite_rounded : Icons.favorite_outline_rounded),label: "Favourite"),
              BottomNavigationBarItem(icon: Icon(selectedIndex == 2 ? Icons.calendar_month : Icons.calendar_month_outlined),label: "Meal Plan"),
              BottomNavigationBarItem(icon: Icon(selectedIndex == 3 ? Icons.settings : Icons.settings_outlined),label: "Setting"),
            ]
        ),
      body: page[selectedIndex],
    );
  }
}
