
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipy/auth_service.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/auth/login_screen.dart';
import 'package:recipy/view/edit_profile_screen.dart';
import 'package:recipy/view/setting/about_us.dart';
import 'package:recipy/view/setting/help_support.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ), // Replace with the desired URL
              ),
              const SizedBox(height: 10),
              const Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Text@gmail.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
              _buildCardTile(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: () {
                  Get.to(()=>EditProfileScreen());
                },
              ),
              const SizedBox(height: 10),
              _buildCardTile(
                icon: Icons.notifications,
                title: "Notifications",
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildCardTile(
                icon: Icons.nightlight,
                title: "Dark Mode",
                onTap: () {
                  // // Toggle the dark mode on and off
                  // _isDarkMode.value = !_isDarkMode.value;
                  // Get.changeTheme(_isDarkMode.value ? ThemeData.dark() : ThemeData.light());
                },
              ),
              const SizedBox(height: 10),
              _buildCardTile(
                icon: Icons.help,
                title: "Help & Support",
                onTap: () {
                  Get.to(()=>HelpSupport());
                },
              ),
              const SizedBox(height: 10),
              _buildCardTile(
                icon: Icons.info,
                title: "About Us",
                onTap: () {
                  Get.to(()=>AboutUs());
                },
              ),
              const SizedBox(height: 30),
              Container(
                width: Get.width,
                height: Get.width / 8,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final pref = Constants.securePreferences();
                    pref.deleteAll();
                    _auth.signOut().then((value) => Get.offAll(()=>LoginScreen()),);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: kPrimaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
