import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';

class InActiveDot extends StatelessWidget {
  const InActiveDot({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 6,
      backgroundColor: AppColors.inActiveDots,
    );
  }
}
