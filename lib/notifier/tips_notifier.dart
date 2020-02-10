import 'package:flutter/material.dart';

class TipsNotifier with ChangeNotifier {
  int tipCounter = 0;
  double price = 0.50;

  void increment() {
    tipCounter++;
    notifyListeners();
  }

  void reset() {
    tipCounter = 0;
    notifyListeners();
  }
}
