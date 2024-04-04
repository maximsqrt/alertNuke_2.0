import 'dart:ui';

import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:flutter/material.dart';

Color determineDayColor(DateTime date, bool isCurrentMonth, YearProvider yearProvider) {
  DateTime now = DateTime.now();
  bool isToday = isCurrentMonth && date.day == now.day && date.year == now.year;
  bool isWeekEndDay = isWeekend(date);

  if (isToday) {
    return Colors.green; // Farbe für den aktuellen Tag
  } else if (isWeekEndDay) {
    return const Color.fromARGB(164, 33, 149, 243); // Eine andere Farbe für Wochenendtage
  } else {
    return Colors.transparent; // Standardfarbe für andere Tage
  }
}

bool isWeekend(DateTime date) {
  return date.weekday == 6 || date.weekday == 7;
}
