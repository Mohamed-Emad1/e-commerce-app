import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/styles.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/core/widgets/custom_button.dart';
import 'package:kshk/features/cart/presentation/cubits/payment_cubit/payment_cubit.dart';
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
                  title: Text(S.of(context).pay_with_stripe),
                ),
                ListTile(
                  leading: Radio<int>(value: 4),
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
              buildScaffoldSnackBar(context, S.of(context).loading);
              BlocProvider.of<PaymentCubit>(context).makePayment(
                selectedMethodIndex: _selectedMethod,
                context: context,
              );
            },
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
