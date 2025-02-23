import 'package:get/get.dart';
import 'package:recipy/controller/LoginController.dart';
import 'package:recipy/controller/controller/ItemController.dart';
import 'package:recipy/controller/controller/QuantityController.dart';


class RootBinding implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut(fenix: true, () => ItemController());
    Get.lazyPut(fenix: true, () => QuantityController());
    Get.lazyPut(fenix: true, () => LoginController());


  }
}
