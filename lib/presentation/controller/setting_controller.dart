
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/core/services/auth_service.dart';
import 'package:recipy/presentation/pages/auth/login_screen.dart';

class SettingController extends GetxController {

  RxBool isLoading = true.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }

  RxString name = "".obs;
  RxString email = "".obs;
  RxString profilePic = "".obs;

  setProfileData() async {
    showLoading();
    final pref = Constants.securePreferences();
    email.value = await pref.read(key: Constants.email) ?? "";
    name.value = await pref.read(key: Constants.name) ?? "";
    profilePic.value = await pref.read(key: Constants.profilePic) ?? "";
    print("------------ ${profilePic}");
    hideLoading();
  }

  signOut(){
    final pref = Constants.securePreferences();
    pref.deleteAll();
    final _auth = AuthService();
    _auth.signOut().then((value) => Get.offAll(()=>LoginScreen()),);
  }

  final usernameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;

}