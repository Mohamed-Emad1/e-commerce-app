import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/Services/srtipe_servcie/stripe_payment_manager.dart';
import 'package:kshk/core/api_keys.dart' show ApiKeys;
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/features/cart/data/models/order_model.dart';
import 'package:kshk/features/cart/domain/entities/payment_entities/paypal_entity/paypal_entity/paypal_entity.dart';
import 'package:kshk/features/cart/presentation/cubits/order_cubit/order_cubit.dart';
import 'package:kshk/generated/l10n.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  void payWithMethod(int selectedIndexMethod, BuildContext context) async {
    final DateTime dateForPlacedOrder = DateTime.now();
    final orderCubit = BlocProvider.of<OrderCubit>(context);
    var uuid = Uuid();
    // Implement payment logic based on selected method
    switch (selectedIndexMethod) {
      case 0:
        payPalPaymentProcess(context, uuid, orderCubit, dateForPlacedOrder);
        await _placeOrder(
          orderCubit: orderCubit,
          dateForPlacedOrder: dateForPlacedOrder,
          orderId: uuid.v4(),
          context: context,
          cashierName: S.of(context).paypal,
        );
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
        log("pay with stripe");
        try {
          // Wait for payment to complete successfully
          await StripePaymentManager.makePayment(
            amount: getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
            currency: kEgpCurrency,
          );

          // Only place order after successful payment
          await _placeOrder(
            orderCubit: orderCubit,
            dateForPlacedOrder: dateForPlacedOrder,
            orderId: uuid.v4(),
            context: context,
            cashierName: S.of(context).stripe_payment,
          );
        } catch (e) {
          // Handle payment errors
          log('Stripe payment error: $e');
          if (context.mounted) {
            String errorMessage = S.of(context).payment_failed;
            if (e.toString().contains('cancelled by user')) {
              errorMessage = S.of(context).payment_cancelled;
            }
            buildScaffoldSnackBar(context, errorMessage);
          }
        }

        break;
      case 4:
        // Cash on Delivery logic
        final orderId = uuid.v4();
        await _placeOrder(
          orderCubit: orderCubit,
          dateForPlacedOrder: dateForPlacedOrder,
          orderId: orderId,
          context: context,
          cashierName: S.of(context).cash_on_delivery,
        );
        log('Paying with Cash on Delivery');
      default:
        log('No payment method selected');
    }
  }

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
            await _placeOrder(
              orderCubit: orderCubit,
              dateForPlacedOrder: dateForPlacedOrder,
              orderId: orderId,
              context: context,
              cashierName: S.of(context).paypal,
            );
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

  _placeOrder({
    required OrderCubit orderCubit,
    required DateTime dateForPlacedOrder,
    required String orderId,
    required BuildContext context,
    required String cashierName,
  }) async {
    await orderCubit.placeOrder(
      orderModel: OrderModel(
        userId: getUserData().uid,
        userName: getUserData().fullName,
        id: orderId,
        cartItems: getIt.get<CartItemsList>().items,
        totalAmount: getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
        orderDate: dateForPlacedOrder,
        cashierName: cashierName,
      ),
    );
    buildScaffoldSnackBar(context, S.of(context).payment_successful);
    GoRouter.of(context).pop();
  }
}
