import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/api_keys.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/features/cart/data/models/order_model.dart';
import 'package:kshk/features/cart/domain/entities/payment_entities/paypal_entity/paypal_entity/paypal_entity.dart';
import 'package:kshk/features/cart/presentation/cubits/order_cubit/order_cubit.dart';
import 'package:kshk/generated/l10n.dart';
import 'package:uuid/uuid.dart';


void payPalPaymentProcess(
  BuildContext context,
  Uuid uuid,
  OrderCubit orderCubit,
  DateTime dateForPlacedOrder,
) {
  var payPalPaymentEntity = PaypalPaymentEntity.fromEntity(
    entity: getIt.get<CartItemsList>(),
  );
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.paypalClientId,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [payPalPaymentEntity.toJson()],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          final orderId = uuid.v4();
          //? TODO: Store order in database
          orderCubit.placeOrder(
            orderModel: OrderModel(
              id: orderId,
              userId: getUserData().uid,
              userName: getUserData().fullName,
              cartItems: getIt.get<CartItemsList>().items,
              totalAmount:
                  getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
              orderDate: dateForPlacedOrder,
              cashierName: S.of(context).paypal,
            ),
          );
          buildScaffoldSnackBar(context, S.of(context).payment_successful);
          GoRouter.of(context).pop();
        },
        onError: (error) {
          log("PayPal Error: $error");

          // Check for specific error types
          String errorMessage = S.of(context).payment_failed;
          if (error is Map) {
            final errorData = error['data'];
            if (errorData != null &&
                errorData['name'] == 'COMPLIANCE_VIOLATION') {
              errorMessage =
                  'PayPal Compliance Error. Please check your sandbox account settings.';
              log('COMPLIANCE_VIOLATION: ${errorData['message']}');
            }
          }

          if (context.mounted) {
            buildScaffoldSnackBar(context, errorMessage);
            GoRouter.of(context).pop();
          }
        },
        onCancel: () {
          buildScaffoldSnackBar(context, S.of(context).payment_cancelled);
          log('cancelled:');
        },
      ),
    ),
  );
  log('Paying with PayPal');
}

void payWithMethod(int selectedMethod, BuildContext context) {
  final DateTime dateForPlacedOrder = DateTime.now();
  final orderCubit = BlocProvider.of<OrderCubit>(context);
  var uuid = Uuid();
  // Implement payment logic based on selected method
  switch (selectedMethod) {
    case 0:
      payPalPaymentProcess(context, uuid, orderCubit, dateForPlacedOrder);
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
      // Cash on Delivery logic
      final orderId = uuid.v4();
      BlocProvider.of<OrderCubit>(context).placeOrder(
        orderModel: OrderModel(
          userId: getUserData().uid,
          userName: getUserData().fullName,
          id: orderId,
          cartItems: getIt.get<CartItemsList>().items,
          totalAmount:
              getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
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
