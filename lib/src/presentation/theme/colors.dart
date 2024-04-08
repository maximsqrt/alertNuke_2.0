
import 'dart:math';

import 'package:flutter/material.dart';


class MonthColor {
  static const Color primaryColor = Color(0xFF6CA7BE);
  static const Color secondaryColor = Color(0xFF2E0B4B);

  static LinearGradient fancyLinearGradient() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [primaryColor, secondaryColor],
      stops: [0.1, 0.7],
      tileMode: TileMode.repeated,
      transform: GradientRotation(45 * 3.1415926535897932 / 180),
    );
  }
}


class JPfancyColor {
  static LinearGradient jpFancyColor() {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.5, 0.9],
      colors: [
        Color(0xFF884082),
        Color(0xFF1E1854),
      
      ],
    );
  }
}
// Background Month // Week // Day 
class BackgroundColor { 



  static const Color primaryColor = Color(0xFF250E22);
}


//Fancy Font Color 
class FancyFontColor {
  static const Color primaryColor = Color.fromARGB(255, 177, 253, 218);
  
}

//FancyButtonColor
class FancyButtonColor {
  static LinearGradient linearGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF7F4CE5),
        Color(0xFF5A35B8),
        Color(0xFF7C2D98),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

//SettingsScreen & SIgnup BackgroundColor
class SettingsBackgroundColor {
  static LinearGradient linearGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF884082),
        Color(0xFF1E1854),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

class DefaultBackgroundColor {
  static final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF6CA7BE), Color(0xFF2E0B4B)],
   
    stops: [0, 1.9],
    transform: GradientRotation(45 * pi / 400),
  );
}


class DefaultDayColor{
  static const primaryColor = Color.fromARGB(160, 255, 255, 255);
}
class AppointmentDayColor {
  static const primaryColor = Color.fromARGB(255, 225, 0, 255);
}
class WeekendDayColor {
  static const sathurdayColor = Color.fromARGB(194, 158, 126, 213);
  static const sundayColor = Color.fromARGB(103, 56, 169, 206);
}
class IsTodayDayColor {
  static const primaryColor = Color.fromARGB(255, 81, 227, 115);
}