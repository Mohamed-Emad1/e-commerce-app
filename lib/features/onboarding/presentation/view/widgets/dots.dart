import 'package:flutter/material.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/active_dot.dart';
import 'package:kshk/features/onboarding/presentation/view/widgets/in_active_dot.dart';

class Dots extends StatelessWidget {
  const Dots({super.key, required this.currentIndex});
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return index == currentIndex ? ActiveDot() : InActiveDot();
      }),
    );
  }
}
