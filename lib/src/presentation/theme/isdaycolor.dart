import 'dart:ui';

import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

Color determineDayColor(DateTime date, bool isCurrentMonth, YearProvider yearProvider) {
  DateTime now = DateTime.now();
  bool isToday = isCurrentMonth && date.day == now.day && date.year == now.year;
  

  if (isToday) {
    return IsTodayDayColor.primaryColor; // Farbe für den aktuellen Tag
  } else if (isSathurday(date)) {
    return WeekendDayColor.sathurdayColor; 
      } else if (isSunday(date)) {
    return WeekendDayColor.sundayColor; /// Eine andere Farbe für Wochenendtage
  } else {
    return Colors.transparent; // Standardfarbe für andere Tage
  }
}

bool isSathurday(DateTime date) {
  return date.weekday == 6 ;
}
bool isSunday(DateTime date) {
  return date.weekday == 7;
}