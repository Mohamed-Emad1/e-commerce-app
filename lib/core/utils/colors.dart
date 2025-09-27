import 'package:flutter/material.dart';

abstract class AppColors {
  // Method to get text color based on current theme
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? const Color(0xFF111827) // textLight
        : const Color(0xFFE5E7EB); // textDark
  }

  // Primary text color (same for both themes)
  static const Color primaryText = Color(0xFF6C63FF);
  static const Color buttonColor = Color(0xFF4F46E5);

  // You can also define theme-specific colors directly in ColorScheme extensions
  static Color getSurfaceVariant(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? const Color(0xFFF3F4F6)
        : const Color(0xFF374151);
  }

  static Color getButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? const Color(0xFF4F46E5) // textLight
        : const Color(0xFF6C63FF); // textDark
  }
  static getTextFieldColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF3F4F6) // textLight
        : Color(0xFF2C2C2C); // textDark
  }

  static const inActiveDots = Color.fromARGB(255, 183, 183, 184);
  static const borderColor = Color(0xFF6B7280);
}
