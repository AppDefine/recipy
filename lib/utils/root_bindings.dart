import 'package:get/get.dart';
import 'package:recipy/controller/login_controller.dart';
import 'package:recipy/controller/meal_plan_controller.dart';
import 'package:recipy/controller/controller/item_controller.dart';
import 'package:recipy/controller/controller/quantity_controller.dart';
import 'package:recipy/controller/setting_controller.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut(fenix: true, () => ItemController());
    Get.lazyPut(fenix: true, () => QuantityController());
    Get.lazyPut(fenix: true, () => LoginController());
    Get.lazyPut(fenix: true, () => MealPlanController());
    Get.lazyPut(fenix: true, () => SettingController());


  }
}
