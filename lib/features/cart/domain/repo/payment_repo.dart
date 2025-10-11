import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:kshk/core/errors/failure.dart';

abstract class PaymentRepo {
  Future<Either<Failure, void>> handlePayment({
    required int selectedIndexMethod,
    required BuildContext context,
  });
}
