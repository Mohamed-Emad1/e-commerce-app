import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/cart/data/models/order_model.dart';
import 'package:kshk/features/cart/presentation/cubits/order_cubit/order_cubit.dart';
import 'package:kshk/features/cart/presentation/view/widgets/calculation_widget.dart';
import 'package:kshk/generated/l10n.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  int _selectedMethod = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        spacing: 16,
        children: [
          Text(
            S.of(context).choose_payment_method,
            style: AppStyles.size18W600(context),
          ),
          RadioGroup<int>(
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value!;
              });
            },
            child: Column(
              children: [
                ListTile(
                  leading: Radio<int>(value: 0),
                  title: Text(S.of(context).paypal),
                ),
                ListTile(
                  leading: Radio<int>(value: 1),
                  title: Text(S.of(context).credit_card),
                ),

                ListTile(
                  leading: Radio<int>(value: 2),
                  title: Text(S.of(context).pay_mob),
                ),
                ListTile(
                  leading: Radio<int>(value: 3),
                  title: Text(S.of(context).cash_on_delivery),
                ),
              ],
            ),
          ),

          CalculationWidget(
            text: S.of(context).total,
            price: getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
          ),

          const Spacer(),
          CustomButton(
            text: S.of(context).continue_button,
            onPressed: () {
              payWithMethod(_selectedMethod, context);
            },
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  void payWithMethod(int selectedMethod, BuildContext context) {
    final DateTime dateForPlacedOrder = DateTime.now();
    // Implement payment logic based on selected method
    switch (selectedMethod) {
      case 0:
        // PayPal payment logic
        log('Paying with PayPal');
        break;
      case 1:
        // Credit Card payment logic
        log('Paying with Credit Card');
        break;
      case 2:
        // PayMob payment logic
        log('Paying with PayMob');
        break;
      case 3:
        BlocProvider.of<OrderCubit>(context).placeOrder(
          orderModel: OrderModel(
            id: getUserData().uid,
            cartItems: getIt.get<CartItemsList>().items,
            totalAmount: getIt.get<CartItemsList>().getTotalPrice(),
            orderDate: dateForPlacedOrder,
            cashierName: S.of(context).cash_on_delivery,
          ),
        );
        buildScaffoldSnackBar(
          context,
          "pay with cash on delivery done and store database",
        );
        log('Paying with Cash on Delivery');
      default:
        log('No payment method selected');
    }
  }
}
