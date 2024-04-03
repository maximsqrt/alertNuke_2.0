import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String imagePath;

  const LogoWidget({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30, // Passe die Breite nach Bedarf an
      height: 30, // Passe die Höhe nach Bedarf an
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}