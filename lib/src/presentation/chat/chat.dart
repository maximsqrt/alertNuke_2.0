import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

final Color gradientStart = const Color(0xFF6CA7BE);
final Color gradientEnd = const Color(0xFF2E0B4B);

class ChatsCalendar extends StatelessWidget {
  final String? user;

  const ChatsCalendar({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(UniconsLine.arrow_circle_left),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
        backgroundColor: Colors.transparent,
        title: Image.asset(
          'assets/AlertNuke.png',
          width: 200,
        ),
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
      body: Center(
        // Verwende Lottie.asset um deine Lottie-Animation anzuzeigen
        child: Lottie.asset('assets/work.json'),
      ),
    );
  }
}
