import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/api_keys.dart';
import 'package:kshk/core/utils/backend_endpoints.dart';

class StripePaymentManager {
  static Future<void> makePayment({
    required double amount,
    required String currency,
  }) async {
    try {
      String cleinSecret = await _getClientSecret(
        amount: (amount * 100).toInt().toString(),
        currency: currency,
      );
      await _initializePaymentSheet(clientSecret: cleinSecret);
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      // Handle Stripe-specific errors (user cancelled, card declined, etc.)
      if (e.error.code == FailureCode.Canceled) {
        throw Exception('Payment cancelled by user');
      }
      throw Exception('Stripe error: ${e.error.message}');
    } on Exception catch (e) {
      throw Exception('Error in Stripe Payment: $e');
    }
  }

  static Future<void> _initializePaymentSheet({
    required String clientSecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Kshk',
      ),
    );
  }

  static Future<String> _getClientSecret({
    required String amount,
    required String currency,
  }) async {
    var dio = getIt.get<Dio>();
    var response = await dio.post(
      BackendEndpoints.stripebaseUrl +
          BackendEndpoints.createStripePaymentIntent,
      data: {'amount': amount, 'currency': currency},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretStripekey}',
          // 'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );
    return response.data['client_secret'];
  }
}
