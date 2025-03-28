
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipy/auth_service.dart';
import 'package:recipy/controller/setting_controller.dart';
import 'package:recipy/ui/setting/about_us.dart';
import 'package:recipy/ui/setting/edit_profile_screen.dart';
import 'package:recipy/ui/setting/help_support.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/widget/privacy_policy.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  SettingController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.setProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  controller.profilePic.value,
                ), // Replace with the desired URL
              ),
              const SizedBox(height: 10),
              Text(
                controller.name.value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                controller.email.value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
              _buildCardTile(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: () async {
                  bool isEdit  =  await Get.to(()=>EditProfileScreen());
                  if(isEdit){
                    controller.setProfileData();
                  }else{

                  }
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
                icon: Icons.help,
                title: "Help & Support",
                onTap: () {
                  Get.to(()=>HelpSupport());
                },
              ),
              const SizedBox(height: 10),
              _buildCardTile(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: () {
                  Get.to(()=>PrivacyPolicy());
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
                  onPressed: () => controller.signOut(),
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
      ),),
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
