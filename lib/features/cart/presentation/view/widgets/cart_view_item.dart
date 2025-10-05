import 'package:flutter/material.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/generated/l10n.dart';

class CartViewItem extends StatelessWidget {
  const CartViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = getIt.get<CartItemsList>();

    return ListenableBuilder(
      listenable: cartService,
      builder: (context, child) {
        final items = cartService.getItems();

        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  S.of(context).empty_cart,
                  style: AppStyles.size14W600(context),
                ),
                const SizedBox(height: 8),
                Text(
                  S.of(context).add_items_to_cart,
                  style: AppStyles.size14W600(
                    context,
                  ).copyWith(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = items[index];
            return Row(
              spacing: 10,
              children: [
                Expanded(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          items[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(items[index].name),
                    subtitle: Text("${items[index].price} EGP"),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.getButtonCartColor(context),
                  child: IconButton(
                    onPressed: () {
                      cartService.decreaseQuantity(item);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),

                Text(
                  cartService.getQuantity(item).toString(),
                  style: AppStyles.size16W400(context),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.getButtonCartColor(context),
                  child: IconButton(
                    onPressed: () {
                      cartService.increaseQuantity(item);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
