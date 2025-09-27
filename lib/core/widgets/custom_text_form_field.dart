import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.onSaved, this.isEmail = false,
  });

  final IconData prefixIcon;
  final String? hintText;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).required_field;
        }
        if (isEmail) {
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if (!emailRegex.hasMatch(value)) {
            return S.of(context).invalid_email;
          }
        }
        return null;
      },
      onSaved: onSaved,
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
