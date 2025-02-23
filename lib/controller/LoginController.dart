
import 'package:get/get.dart';

class LoginController  extends GetxController{

  RxBool isLoading = false.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }
}