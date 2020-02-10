import 'package:Dachboden/drink.dart';
import 'package:flutter/material.dart';

class DrinksNotifier with ChangeNotifier {
  List<Drink> drinks = <Drink>[
    Drink('Bier', 1),
    Drink('Cola', 1.5),
    Drink('Mate', 1.5),
    Drink('Cocktail', 2.5),
    Drink('Schnaps', 1),
    Drink('Rix', 1),
  ];

  void increment(int index) {
    drinks[index].increment();
    notifyListeners();
  }

  void decrement(int index) {
    if (drinks[index].buyCounter <= 0) return;
    drinks[index].decrement();
    notifyListeners();
  }

  void reset() {
    for (final drink in this.drinks) {
      drink.buyCounter = 0;
    }
    notifyListeners();
  }
}
