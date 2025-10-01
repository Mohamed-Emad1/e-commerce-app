import 'package:flutter/material.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

class DetailedScreenTitle extends StatelessWidget {
  const DetailedScreenTitle({super.key, required this.item});

  final ItemCardEntity item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(item.title, style: AppStyles.size24W800(context)),
          ),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: AppStyles.size18W700(context),
          ),
        ],
      ),
    );
  }
}
