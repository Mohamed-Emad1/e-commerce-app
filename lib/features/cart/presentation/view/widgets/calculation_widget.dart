import 'package:flutter/material.dart';
import 'package:kshk/core/utils/styles.dart';

class CalculationWidget extends StatelessWidget {
  const CalculationWidget({super.key, required this.price, required this.text});

  final double price;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.size16W400(context)),
        Text(
          'USD ${price.toStringAsFixed(2)}',
          style: AppStyles.size18W700(context),
        ),
      ],
    );
  }
}
