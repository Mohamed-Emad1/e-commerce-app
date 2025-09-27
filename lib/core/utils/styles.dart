import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';

abstract class AppStyles {
  // Text styles that adapt to theme
  static TextStyle size36W700(BuildContext context) => TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size30W700(BuildContext context) => TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size24W800(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size18W600(BuildContext context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size18W700(BuildContext context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size16W400(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size16W500(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size16W600(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  static TextStyle size14W600(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.getTextColor(context),
    fontFamily: 'Poppins',
  );

  // Primary text styles (using primaryText color)
  static const TextStyle size18W700Primary = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    fontFamily: 'Poppins',
  );

  static const TextStyle size16W600Primary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    fontFamily: 'Poppins',
  );
}
