import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';

void buildScaffoldSnackBar(
  BuildContext context,
  String text, {
  Color color = AppColors.primaryText,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(text, style: AppStyles.size24W800(context)),
    ),
  );
}
