import 'package:flutter/material.dart';
import 'package:kshk/core/utils/styles.dart';

void buildScaffoldSnackBar(
  BuildContext context,
  String text, {
  Color color = Colors.red,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(text, style: AppStyles.size24W800(context)),
    ),
  );
}
