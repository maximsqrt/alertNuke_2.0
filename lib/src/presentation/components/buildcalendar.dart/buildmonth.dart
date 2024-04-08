import 'package:alertnukeapp_ver2/src/Services/calendar_services/datetimecalc.dart';
import 'package:alertnukeapp_ver2/src/Services/calendar_services/gotappointment.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/isdaycolor.dart';
import 'package:flutter/material.dart';

Widget buildMonthPage(int monthIndex, YearProvider yearProvider,
    double childAspectRatio, int fontSize,
    {required Function(int) dayCallback}) {
  int actualFontSize = fontSize;

  // Anpassung hier: Monatsindex + 1, um von 0-basierter zu 1-basierter Indexierung zu wechseln

  int correctedMonthIndex = monthIndex + 1;

  DateTime now = DateTime.now();
  // Erstelle eine Instanz von DateTimeCalc mit dem gegebenen Jahr
  DateTimeCalc dateTimeCalc = DateTimeCalc(yearProvider.year);
  bool isCurrentMonth =
      now.month == correctedMonthIndex && now.year == yearProvider.year;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      gradient: MonthColor.fancyLinearGradient(),
    ),
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      // Verwende dateTimeCalc, um die Anzahl der Tage im Monat zu erhalten
      itemCount: dateTimeCalc.daysInMonth(correctedMonthIndex),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: .5,
        crossAxisSpacing: 1,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        int day = index + 1;
        bool isToday = isCurrentMonth && day == now.day;

        DateTime date = DateTime(yearProvider.year, correctedMonthIndex, day);
        Color currentday_weekandcolor = determineDayColor(date, isCurrentMonth, yearProvider);

        return FutureBuilder<bool>(
            future: AppointmentUtils.hasAppointmentsOnDay(date),
            builder: (context, snapshot) {
              Color dayColor;
              if (snapshot.connectionState == ConnectionState.waiting) {
                dayColor = Colors
                    .transparent; // Default color while loading or if there's no data
              } else if (snapshot.hasData && snapshot.data!) {
                dayColor = AppointmentDayColor
                    .primaryColor; // Color indicating an appointment exists
              } else {
                dayColor = DefaultDayColor.primaryColor; // No appointments
              }

              // Use dayColor determined by FutureBuilder for the border color
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
                        width: 0.70,
                        color: dayColor,
                      ),
                      borderRadius: BorderRadius.circular(6.0),

                      ///Diff Color for today?
                      color: currentday_weekandcolor,
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: actualFontSize.toDouble(),
                          color: dayColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    ),
  );
}
