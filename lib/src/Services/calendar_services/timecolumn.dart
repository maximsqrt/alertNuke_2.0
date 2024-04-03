import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeColumn extends StatelessWidget {
  final ScrollController timeController;
  final DateTime now;

  const TimeColumn({required this.timeController, required this.now});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          DateFormat('MMMM').format(DateTime(now.year, now.month, 1)),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          DateFormat('dd / MM / yy').format(now),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          DateFormat('EEEE').format(now),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}

