import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/app_router.dart';
import 'package:kshk/core/utils/colors.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/cart/presentation/view/widgets/calculation_widget.dart';
import 'package:kshk/features/cart/presentation/view/widgets/cart_view_item.dart';
import 'package:kshk/generated/l10n.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = getIt.get<CartItemsList>();

    return ListenableBuilder(
      listenable: cartService,
      builder: (context, child) {
        final subtotal = cartService.getTotalPrice();
        final total = subtotal + kShippingCost;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SingleChildScrollView(child: Column(children: [CartViewItem()])),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).order_summary,
                  style: AppStyles.size18W700(context),
                ),
              ),
              Divider(color: AppColors.primaryText),
              CalculationWidget(text: S.of(context).subtotal, price: subtotal),
              CalculationWidget(
                text: S.of(context).shipping,
                price: kShippingCost,
              ),
              CalculationWidget(text: S.of(context).total, price: total),
              SizedBox(height: 15),
              CustomButton(
                text: S.of(context).checkout,
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kCheckout);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
