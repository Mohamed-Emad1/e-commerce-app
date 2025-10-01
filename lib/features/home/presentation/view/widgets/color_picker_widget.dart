import 'package:flutter/material.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Color.fromARGB(255, 216, 236, 184),
                size: 30,
              )
            : null,
      ),
    );
  }
}
