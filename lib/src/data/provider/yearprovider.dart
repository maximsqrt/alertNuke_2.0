import 'package:flutter/material.dart';
class YearProvider extends ChangeNotifier {
    int _year = DateTime.now().year;

    int get year => _year;

void incrementYear() {
  _year += 1 ;
  notifyListeners(); // If YearProvider extends ChangeNotifier
}

void decrementYear() {
  _year -= 1;
  notifyListeners(); // If YearProvider extends ChangeNotifier
}

void changeYear(int newYear) {
    _year = newYear; // Set _year to newYear instead of adding
    notifyListeners();
}

}