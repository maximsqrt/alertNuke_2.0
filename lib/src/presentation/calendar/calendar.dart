
import 'package:alertnukeapp_ver2/src/data/provider/calendarstateprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/calendar/day.dart';
import 'package:alertnukeapp_ver2/src/presentation/calendar/month.dart';
import 'package:alertnukeapp_ver2/src/presentation/calendar/year.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _Calendar createState() => _Calendar();
}


//enum CalendarStatus { year, month, day }

class _Calendar extends State<Calendar> {
int selectedMonthIndex = 0;
  int selectedYearIndex = DateTime.now().year; // Startjahr setzen, z.B. das aktuelle Jahr
  int selectedDayIndex = 0;
void changeMonthStatus(int newMonthIndex) {
    setState(() {
      selectedMonthIndex = newMonthIndex;
      Provider.of<CalendarStateProvider>(context, listen: false).changeStateToMonth();
    });
  }

  void changeDayStatus(int newDayIndex) {
    setState(() {
      selectedDayIndex = newDayIndex;
      Provider.of<CalendarStateProvider>(context, listen: false).changeStateToDay();
    });
  }
    void changeYearStatus(int newYearIndex) {
    setState(() {
      selectedYearIndex = newYearIndex;
      Provider.of<CalendarStateProvider>(context, listen: false).changeStateToYear();
    });
  }


  

@override
Widget build(BuildContext context) {
final calenderProvider = Provider.of<CalendarStateProvider>(context);
  // ignore: unused_local_variable, no_leading_underscores_for_local_identifiers
  ScrollController _scrollController = ScrollController();




  
 if (calenderProvider.getState() == CalendarState.year) {
      return YearCalendar(
        changeMonthStatus: changeMonthStatus,
        changeDayStatus: changeDayStatus,
        selectedYear: selectedYearIndex, ///DateTime(selectedDate.year, widget.selectedDate.month  );
        changeYearStatus: changeYearStatus, // Übergabe der Funktion an YearCalendar
      );
  } else if (calenderProvider.getState() == CalendarState.month) {
    return MonthCalendar(monthIndex: selectedMonthIndex, selectedYear: selectedYearIndex, dayCallback: (day) => changeDayStatus(day));
  } else if (calenderProvider.getState() == CalendarState.day) {
    return DayCalendar(selectedDay: selectedDayIndex, monthNumber: selectedMonthIndex, selectedDate: DateTime(selectedYearIndex, selectedMonthIndex  ),);
  } else { throw Error();       }
}
 
}
