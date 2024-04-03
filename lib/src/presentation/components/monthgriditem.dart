

import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';

import 'package:alertnukeapp_ver2/src/Services/calendar_services/datehelperservice.dart';
import 'package:alertnukeapp_ver2/src/presentation/components/buildcalendar.dart/buildmonth.dart';
import 'package:flutter/material.dart';

class MonthGridItem extends StatelessWidget {

  final int monthIndex;
  final YearProvider yearProvider;
  Function(int) showMonth;
  Function(int) dayCallback;
  
 MonthGridItem({super.key, required this.monthIndex, required this.yearProvider, required this.showMonth,required this.dayCallback});

  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap: () => showMonth(monthIndex +1),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              dateHelperService.monthNames[monthIndex],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                child: buildMonthPage(monthIndex  , yearProvider,1, 10,dayCallback: (day) => dayCallback(day)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}