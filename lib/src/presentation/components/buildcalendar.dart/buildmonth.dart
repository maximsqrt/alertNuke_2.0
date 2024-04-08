import 'package:alertnukeapp_ver2/src/Services/calendar_services/datetimecalc.dart';
import 'package:alertnukeapp_ver2/src/Services/calendar_services/gotappointment.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/isdaycolor.dart';
import 'package:flutter/material.dart';

Widget buildMonthPage(
    int monthIndex, YearProvider yearProvider, double childAspectRatio, int fontSize, {required Function(int) dayCallback}) {
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
    child: buildMonthGridView(correctedMonthIndex, dateTimeCalc, isCurrentMonth, childAspectRatio, fontSize, dayCallback, yearProvider, now),
  );
}
Widget buildDayWithAppointmentIndicator(DateTime date, bool isCurrentMonth, YearProvider yearProvider, int day, double childAspectRatio, int fontSize, Function(int) dayCallback) {
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

        return buildDayContainer(day, dayColor, currentDayWeekAndColor, childAspectRatio, fontSize, dayCallback);
      });
}
Widget buildDayContainer(int day, Color dayColor, Color backgroundColor, double childAspectRatio, int fontSize, Function(int) dayCallback) {
//  print("Day cast in buildDayContainer: $day");
  return GestureDetector(
    onTap: () {
      print("Day tapped: $day");
      dayCallback(day);
    },
    child: AspectRatio(
      aspectRatio: childAspectRatio,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.70, color: dayColor),
          borderRadius: BorderRadius.circular(6.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize.toDouble(),
              color: dayColor,
            ),
          ),
        ),
      ),
    ),
  );
}
Widget buildMonthGridView(int correctedMonthIndex, DateTimeCalc dateTimeCalc, bool isCurrentMonth, double childAspectRatio, int fontSize, Function(int) dayCallback, YearProvider yearProvider, DateTime now) {
  return GridView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    itemCount: dateTimeCalc.daysInMonth(correctedMonthIndex),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 7,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: childAspectRatio,
    ),
    itemBuilder: (context, index) {
      int day = index + 1;
      bool isToday = isCurrentMonth && day == now.day;
      DateTime date = DateTime(yearProvider.year, correctedMonthIndex, day);
      return buildDayWithAppointmentIndicator(date, isCurrentMonth, yearProvider, day, childAspectRatio, fontSize, dayCallback);
    },
  );
}
