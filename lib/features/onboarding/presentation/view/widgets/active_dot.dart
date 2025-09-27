import 'package:flutter/material.dart';

class ActiveDot extends StatelessWidget {
  const ActiveDot({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 20,
      height: 10,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? const Color(0xFF4F46E5)
            : const Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}