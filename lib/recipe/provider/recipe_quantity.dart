import 'package:wtfc_provider_app/export.dart';

class RecipeQuantityProvider extends ChangeNotifier {
  int _currentNumber = 1;

  List<double> _baseIngredientAmounts = [];
  int get currentNumber => _currentNumber;

  //set initial amounts

  void setBaseIngredientAmounts(List<double> amounts) {
    _baseIngredientAmounts = amounts;

    notifyListeners();
  }

  //update ingredient amounts based on the quantity
  List<String> get updateIngredientAmounts {
    return _baseIngredientAmounts
        .map<String>((amount) => (amount * _currentNumber).toStringAsFixed(1))
        .toList();
  }

  //increase servings
  void increaseQuantity() {
    _currentNumber++;
    notifyListeners();
  }

  //decrease servings
  void decreaseQuantity() {
    if (_currentNumber > 1) {
      _currentNumber--;
      notifyListeners();
    }
  }
}
