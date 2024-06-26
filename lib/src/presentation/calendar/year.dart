
import 'dart:math';

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
    Key? key,
    required this.changeDayStatus,
    required this.changeMonthStatus,
    required this.selectedYear,
    required this.changeYearStatus,
  }) : super(key: key);

  @override
  _YearCalendarState createState() => _YearCalendarState();
}

class _YearCalendarState extends State<YearCalendar> {
  void _updateYear(int yearToAdd) {
    // Access YearProvider
    final yearProvider = Provider.of<YearProvider>(context, listen: false);
    
    // Calculate and update the new year
    yearProvider.changeYear(yearProvider.year + yearToAdd);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final yearProvider = Provider.of<YearProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          yearProvider.year.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: FancyFontColor.primaryColor,
            fontSize: 50,
          ),
        ),
        leading: IconButton(
          icon: Icon(UniconsLine.arrow_down, color: Colors.white, size: 50.0),
          onPressed: () => _updateYear(-1),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(UniconsLine.arrow_up, color: Colors.white, size: 50.0),
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
      body: buildYearCalendarBody(_scrollController, yearProvider),
    );
  }

  Widget buildYearCalendarBody(ScrollController controller, YearProvider yearProvider) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6CA7BE), Color(0xFF2E0B4B)],
          tileMode: TileMode.repeated,
          stops: [0.1, 0.9],
          transform: GradientRotation(45 * pi / 180),
        ),
      ),
      child: Column(
        children: [
          TimeColumn(timeController: controller, now: DateTime.now()),
          buildMonthsGridView(yearProvider),
        ],
      ),
    );
  }

  Widget buildMonthsGridView(YearProvider yearProvider) {
    return Flexible(
      child: GridView.builder(
        key: PageStorageKey('MonthGridView-${yearProvider.year}'),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) => buildMonthCard(index, yearProvider),
      ),
    );
  }

  Widget buildMonthCard(int index, YearProvider yearProvider) {
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
              showMonth: (newMonthIndex) => widget.changeMonthStatus(newMonthIndex - 2),
              dayCallback: widget.changeDayStatus,
            ),
          ),
        ),
      ],
    );
  }
}
