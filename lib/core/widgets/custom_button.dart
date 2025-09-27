import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.getButtonColor(
            context,
          ), // You can customize the button color
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          overlayColor: Colors.white.withValues(alpha: 0.1),
        ),

        onPressed: onPressed,
        child: Text(
          text,
          style: AppStyles.size18W600(context).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
