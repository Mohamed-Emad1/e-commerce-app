import 'package:dartz/dartz.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/features/cart/data/models/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, void>> placeOrder({required OrderModel orderModel});
}
