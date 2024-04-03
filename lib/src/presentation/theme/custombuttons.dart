import 'package:flutter/material.dart';

class FancyButton extends StatelessWidget {
  const FancyButton({
    required Key key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
          
          ],
          borderRadius: BorderRadius.circular(30),
          gradient: FancyButtonColor2.linearGradient(), // Use linearGradient method from FancyButtonColor class
        ),
        width: 150,
        height: 70,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white), // Set text color to white
          ),
        ),
      ),
    );
  }
}

class FancyButtonColor2 {
  static LinearGradient linearGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF7F4CE5),
        Color(0xFF5A35B8),
        Color(0xFF7C2D98),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}