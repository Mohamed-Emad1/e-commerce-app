import 'package:flutter/material.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

class SizePickerWidget extends StatelessWidget {
  const SizePickerWidget({
    super.key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  final ItemSize size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getTextFieldColor(context)
              : AppColors.getSurfaceVariant(context),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Theme.of(context).primaryColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(size.shortName, style: AppStyles.size16W600(context)),
        ),
      ),
    );
  }
}
