import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:go_router/go_router.dart';
import 'package:kshk/core/Services/paymob_service/paymob_manager.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/Services/srtipe_servcie/stripe_payment_manager.dart';
import 'package:kshk/core/api_keys.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/core/widgets/build_scaffoldMessenger.dart';
import 'package:kshk/features/cart/data/models/order_model.dart';
import 'package:kshk/features/cart/domain/entities/payment_entities/paypal_entity/paypal_entity/paypal_entity.dart';
import 'package:kshk/features/cart/presentation/cubits/order_cubit/order_cubit.dart';
import 'package:kshk/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  final PaymobManager paymobManager;

  PaymentService({required this.paymobManager});

  void payWithMethod(int selectedIndexMethod, BuildContext context) async {
    // Cache all localized strings before any async operations
    final localizations = S.of(context);

    final DateTime dateForPlacedOrder = DateTime.now();
    final orderCubit = BlocProvider.of<OrderCubit>(context, listen: false);
    var uuid = const Uuid();

    // Implement payment logic based on selected method
    switch (selectedIndexMethod) {
      case 0:
        payPalPaymentProcess(
          context,
          uuid,
          orderCubit,
          dateForPlacedOrder,
          localizations,
        );
        break;
      case 2:
        log('Paying with PayMob');
        try {
          await _payWithPaymob(
            amount: getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
          );
          await _placeOrder(
            orderCubit: orderCubit,
            dateForPlacedOrder: dateForPlacedOrder,
            orderId: uuid.v4(),
            context: context,
            cashierName: localizations.pay_mob,
            localizations: localizations,
          );
        } catch (e) {
          log('PayMob payment error: $e');
          if (context.mounted) {
            buildScaffoldSnackBar(context, localizations.payment_failed);
          }
        }
        break;
      case 3:
        log("pay with stripe");
        try {
          await StripePaymentManager.makePayment(
            amount: getIt.get<CartItemsList>().getTotalPrice() + kShippingCost,
            currency: kEgpCurrency,
          );

          await _placeOrder(
            orderCubit: orderCubit,
            dateForPlacedOrder: dateForPlacedOrder,
            orderId: uuid.v4(),
            context: context,
            cashierName: localizations.stripe_payment,
            localizations: localizations,
          );
        } catch (e) {
          log('Stripe payment error: $e');
          if (context.mounted) {
            String errorMessage = localizations.payment_failed;
            if (e.toString().contains('cancelled by user')) {
              errorMessage = localizations.payment_cancelled;
            }
            buildScaffoldSnackBar(context, errorMessage);
          }
        }
        break;
      case 4:
        final orderId = uuid.v4();
        await _placeOrder(
          orderCubit: orderCubit,
          dateForPlacedOrder: dateForPlacedOrder,
          orderId: orderId,
          context: context,
          cashierName: localizations.cash_on_delivery,
          localizations: localizations,
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
    S localizations,
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
            await _placeOrder(
              orderCubit: orderCubit,
              dateForPlacedOrder: dateForPlacedOrder,
              orderId: orderId,
              context: context,
              cashierName: localizations.paypal,
              localizations: localizations,
            );
          },
          onError: (error) {
            log("PayPal Error: $error");

            String errorMessage = localizations.payment_failed;
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
            if (context.mounted) {
              buildScaffoldSnackBar(context, localizations.payment_cancelled);
            }
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
    required S localizations,
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
    if (context.mounted) {
      buildScaffoldSnackBar(context, localizations.payment_successful);
      GoRouter.of(context).pop();
    }
  }

  Future<void> _payWithPaymob({required double amount}) async {
    try {
      final String paymentKey = await paymobManager.getPaymentKey(
        amount: amount,
        currency: kEgpCurrency,
      );
      await launchUrl(
        Uri.parse(
          "https://accept.paymob.com/api/acceptance/iframes/968045?payment_token=$paymentKey",
        ),
      );
    } catch (e) {
      log('PayMob payment error: $e');
    }
  }
}
