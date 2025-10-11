import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:kshk/core/Services/payment_service.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/features/cart/domain/repo/payment_repo.dart';

class PaymentRepoImp extends PaymentRepo {
  final PaymentService paymentService;

  PaymentRepoImp({required this.paymentService});
  @override
  Future<Either<Failure, void>> handlePayment({
    required int selectedIndexMethod,
    required BuildContext context,
  }) async {
    try {
      paymentService.payWithMethod(selectedIndexMethod, context);
      return right(null);
    } catch (e) {
      log("exception happened in payment methods");
      return Left(ServerFailure(e.toString()));
    }
  }
}
