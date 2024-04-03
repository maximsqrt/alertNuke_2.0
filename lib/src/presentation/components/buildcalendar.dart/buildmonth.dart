

import 'package:alertnukeapp_ver2/src/Services/calendar_services/datetimecalc.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

Widget buildMonthPage(int monthIndex, YearProvider yearProvider,  double childAspectRatio, int fontSize, {required Function(int) dayCallback}) {
  int actualFontSize = fontSize;


  // Anpassung hier: Monatsindex + 1, um von 0-basierter zu 1-basierter Indexierung zu wechseln
  int correctedMonthIndex = monthIndex + 1;
 
  
  DateTime now = DateTime.now();
  // Erstelle eine Instanz von DateTimeCalc mit dem gegebenen Jahr
  DateTimeCalc dateTimeCalc = DateTimeCalc(yearProvider.year);
   bool isCurrentMonth = now.month == correctedMonthIndex && now.year == yearProvider.year;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      gradient: MonthColor.fancyLinearGradient(),
    ),
    child: GridView.builder(
      padding: EdgeInsets.zero,
      // Verwende dateTimeCalc, um die Anzahl der Tage im Monat zu erhalten
      itemCount: dateTimeCalc.daysInMonth(correctedMonthIndex),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        int day = index + 1;
        bool isToday = isCurrentMonth && day == now.day;

        return GestureDetector(
          onTap: () {
              print("Day tapped: $day");
            dayCallback(day);
          },
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.30,
                  color: const Color.fromARGB(117, 127, 76, 229),
                ),
                borderRadius: BorderRadius.circular(9.0),
                ///Diff Color for today? 
                color: isToday? Colors.red : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: actualFontSize.toDouble(),
                    color: const Color.fromARGB(187, 233, 220, 220),

                  ),
                  
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
