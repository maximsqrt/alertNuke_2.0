// search_bar.dart

import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

///Search BAR!
class FancySearch extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const FancySearch({super.key, 
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: 'Search for Icon',
          prefixIcon: const Icon(UniconsLine.search),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}