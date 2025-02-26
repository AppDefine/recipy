import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuantityController extends GetxController {

  RxInt _currentNumber = 1.obs;
  RxList<double> _baseIngredientAmounts = <double>[0.0].obs;

  int get currentNumber => _currentNumber.value;

  // Set initial ingredient amounts
  void setBaseIngredientAmounts(List<double> amounts) {
    _baseIngredientAmounts.assignAll(amounts);
  }

  // Update ingredient amounts based on the quantity
  List<String> get updateIngredientAmounts {
    return _baseIngredientAmounts
        .map<String>(
            (amount) => (amount * _currentNumber.value).toStringAsFixed(1))
        .toList();
  }

  // Increase servings
  void increaseQuantity() {
    _currentNumber++;
  }

  // Decrease servings
  void decreaseQuantity() {
    if (_currentNumber > 1) {
      _currentNumber--;
    }
  }
}
