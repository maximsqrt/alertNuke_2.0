import 'package:flutter/material.dart';

class CalendarStateProvider extends ChangeNotifier {

  CalendarState _status = CalendarState.year;
  
  void changeStateToYear() {
    _status = CalendarState.year;
    print("Calendarstat ${_status}");
    notifyListeners();
  }

  void changeStateToMonth() {
    _status = CalendarState.month;
    print("Calendarstat ${_status}");
    notifyListeners();
  }

  void changeStateToDay() {
    _status = CalendarState.day;
    print("Calendarstat ${_status}");
    notifyListeners();
  }

  CalendarState getState() {
    print("Calendarstat getstate ${_status}");
    return _status;
  }

}

enum CalendarState { year, month, day }