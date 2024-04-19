import 'package:alertnukeapp_ver2/src/Services/calendar_services/datetimecalc.dart';
import 'package:alertnukeapp_ver2/src/Services/calendar_services/gotappointment.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/isdaycolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget buildMonthPage2(
    int monthIndex, YearProvider yearProvider, double childAspectRatio,  {required Function(int) dayCallback}) {
  // Anpassung hier: Monatsindex + 1, um von 0-basierter zu 1-basierter Indexierung zu wechseln
  int correctedMonthIndex = monthIndex + 1;
  DateTime now = DateTime.now();
  DateTimeCalc dateTimeCalc = DateTimeCalc(yearProvider.year);
  bool isCurrentMonth = now.month == correctedMonthIndex && now.year == yearProvider.year;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      gradient: MonthColor.fancyLinearGradient(),
    ),
    child: buildMonthGridView2(correctedMonthIndex, dateTimeCalc, isCurrentMonth, childAspectRatio, dayCallback, yearProvider, now),
  );
}
Widget buildDayWithAppointmentIndicator(DateTime date, bool isCurrentMonth, YearProvider yearProvider, int day, double childAspectRatio,  Function(int) dayCallback) {
//  print("Day cast in builddaywithapp....: $day");
  Color currentDayWeekAndColor = determineDayColor(date, isCurrentMonth, yearProvider);
  return FutureBuilder<bool>(
      future: AppointmentUtils.hasAppointmentsOnDay(date),
      builder: (context, snapshot) {
        Color dayColor = snapshot.connectionState == ConnectionState.waiting
            ? Colors.transparent
            : snapshot.hasData && snapshot.data!
                ? AppointmentDayColor.primaryColor
                : DefaultDayColor.primaryColor;

        return buildDayContainer(day, dayColor, currentDayWeekAndColor, childAspectRatio,  dayCallback);
      });
}
Widget buildDayContainer(int day, Color dayColor, Color backgroundColor, double childAspectRatio, Function(int) dayCallback) {
//  print("Day cast in buildDayContainer: $day");
  return GestureDetector(
    onTap: () {
      print("Day tapped: $day");
      dayCallback(day);
    },
    child: AspectRatio(
      aspectRatio: childAspectRatio,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        //calculate fontsize dependend of container 
        double minSize = constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;
         double calculatedFontSize = minSize *.4;
      
      
      
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.1, color: dayColor),
          borderRadius: BorderRadius.circular(3.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: calculatedFontSize,
              color: dayColor,
              ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
Widget buildMonthGridView2(
    int correctedMonthIndex,
    DateTimeCalc dateTimeCalc,
    bool isCurrentMonth,
    double childAspectRatio,
    Function(int) dayCallback,
    YearProvider yearProvider,
    DateTime now) {
  return LayoutBuilder(builder: (context, constraints) {
    // Determining the number of rows based on the typical number of weeks in a month
    int numberOfRows = 5;  // This can vary if you want to adapt based on actual month layout
    double availableHeight = constraints.maxHeight / numberOfRows;

    // Adjusting childAspectRatio based on the width of the container and the calculated available height
    double adjustedAspectRatio = constraints.maxWidth / (availableHeight * 7); // 7 columns, for days of the week

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: dateTimeCalc.daysInMonth(correctedMonthIndex),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: adjustedAspectRatio,  // Using the adjusted aspect ratio here
      ),
      itemBuilder: (context, index) {
        int day = index + 1;
        bool isToday = isCurrentMonth && day == now.day;
        DateTime date = DateTime(yearProvider.year, correctedMonthIndex, day);
        return buildDayWithAppointmentIndicator(date, isCurrentMonth, yearProvider, day, adjustedAspectRatio, dayCallback);
      },
    );
  });
}
