import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kshk/core/Services/service_locator.dart';
import 'package:kshk/core/api_keys.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';

class PaymobManager {
  Future<String> getPaymentKey({
    required double amount,
    required String currency,
  }) async {
    try {
  String authToken = await _getAuthToken();
  int orderID = await _getOrderID(
    amount: (amount * 100).toString(),
    authToken: authToken,
  );
  
  String paymentKey = await _getPaymentKey(
    authToken: authToken,
    amount: (amount * 100).toString(),
    currency: currency,
    orderID: orderID.toString(),
  );
  return paymentKey;
} on ServerFailure catch (e) {
      log("ServerFailure in PaymobManager getPaymentKey : ${e.message}");
      rethrow;
    } catch (e) {
      log("Exception in PaymobManager getPaymentKey : ${e.toString()}");
      throw ServerFailure(e.toString());
}
  }


  Future<String> _getAuthToken() async {
    var response = await getIt.get<Dio>().post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {"api_key": ApiKeys.paymobApiKey},
    );
    return response.data['token'];
  }
  
  Future<int> _getOrderID({required String authToken,required String amount}) async {
    var response = await getIt.get<Dio>().post(
      'https://accept.paymob.com/api/ecommerce/orders',
      data: {
        "auth_token": authToken,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": kEgpCurrency,
        "items": []
      },
    );
    return response.data['id'];
  }
  
  Future<String> _getPaymentKey({required String authToken, required String amount, required String currency, required String orderID}) async {
    var response = await getIt.get<Dio>().post(
      'https://accept.paymob.com/api/acceptance/payment_keys',
      data: {
        "auth_token": authToken,
        "amount_cents": amount,
        "expiration": 3600,
        "order_id": orderID,
                "currency": currency,
        "integration_id": ApiKeys.paymobIntegrationIdCard, // your integration id
        "billing_data": {
          "email": getUserData().email,
          "first_name": getUserData().fullName.split(" ").first,
          "last_name": getUserData().fullName.split(" ").last,
          "phone_number": "01032746151",

          // Dummy data for required fields can be NA or any placeholder
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "state": "NA"
        },
      },
    );
    return response.data['token'];
  }
}
