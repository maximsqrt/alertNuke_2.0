

// ignore_for_file: library_private_types_in_public_api

import 'package:alertnukeapp_ver2/src/Services/calendar_services/timecolumn.dart';
import 'package:alertnukeapp_ver2/src/data/provider/yearprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/components/monthgriditem.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class YearCalendar extends StatefulWidget {
  final Function(int) changeMonthStatus;
  final Function(int) changeDayStatus;
  final int selectedYear;
  final Function(int) changeYearStatus;

  const YearCalendar({
    super.key,
    required this.changeDayStatus,
    required this.changeMonthStatus,
    required this.selectedYear,
    required this.changeYearStatus,
  });

  @override
  _YearCalendarState createState() {
    
    
    return _YearCalendarState();
    
    }
}

class _YearCalendarState extends State<YearCalendar> {

  void _updateYear(int yearToAdd) {
    // get instance of YearProvider from context of Widget Tree
    // listen false -> _YearCalendarState not rebuild
    final yearProvider = Provider.of<YearProvider>(context, listen: false);
    
    // Calculate and update the new year
    yearProvider.changeYear(yearProvider.year + yearToAdd);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final yearProvider = Provider.of<YearProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          yearProvider.year.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: FancyFontColor.primaryColor,
            fontSize: 50,
          ),
        ),
        leading: IconButton(
          icon: const Icon(UniconsLine.arrow_down, color: Colors.white, size: 50.0),
          onPressed: () => _updateYear(-1),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(UniconsLine.arrow_up, color: Colors.white, size: 50.0),
            onPressed: () => _updateYear(1),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF6CA7BE), Color(0xFF2E0B4B)],
            ),
          ),
        ),
      ),
      body: buildYearCalendarBody(scrollController, yearProvider),
    );
  }

//Build Body for the Calendar

  Widget buildYearCalendarBody(ScrollController controller, YearProvider yearProvider) {
    return Container(
      decoration: BoxDecoration(gradient: DefaultBackgroundColor.gradient),
      child: Column(
        children: [
          TimeColumn(timeController: controller, now: DateTime.now()),
          buildMonthsGridView(yearProvider),
        ],
      ),
    );
  }
//Create GridView for all 12 Months with data from YearProvider
  Widget buildMonthsGridView(YearProvider yearProvider) {
   
    return Flexible(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        key: PageStorageKey('MonthGridView-${yearProvider.year}'),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index){ 
          //  print('month Card Index: $index');
           return buildMonthCard(index, yearProvider);
        }
      ),
    );
  }
//Create Card for every Month 
  Widget buildMonthCard(int index, YearProvider yearProvider) {
    // print('month Card Index: $index');
    return Column(
      children: [
        Card(
          color: const Color.fromARGB(114, 0, 0, 0),
          elevation: 3,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: MonthGridItem(
              monthIndex: index,
              
              yearProvider: yearProvider,
              //Gesturedetector for on tap buildmonthScreen defined in @monthgriditem
              showMonth: (newMonthIndex) => widget.changeMonthStatus(newMonthIndex),
              dayCallback: widget.changeDayStatus,
            ),
          ),
        ),
      ],
    );
  }
}
