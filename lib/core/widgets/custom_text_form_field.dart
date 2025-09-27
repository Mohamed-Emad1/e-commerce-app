import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
  });

  final IconData prefixIcon;
  final String? hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        hintStyle: AppStyles.size16W400(context),
        fillColor: AppColors.getTextFieldColor(context),
        border: buildoutLinedInputBorder(),
        enabledBorder: buildoutLinedInputBorder(),
      ),
    );
  }

  OutlineInputBorder buildoutLinedInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.borderColor),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
