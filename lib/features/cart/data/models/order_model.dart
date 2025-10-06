import 'package:kshk/core/utils/entities/cart_item_entity.dart';

class OrderModel {
  final String id;
  final List<CartItemEntity> cartItems;
  final double totalAmount;
  final DateTime orderDate;
  final String cashierName;

  OrderModel({
    required this.id,
    required this.cartItems,
    required this.totalAmount,
    required this.orderDate,
    required this.cashierName,
  });

  factory OrderModel.fromOrderItemEntity({
    required String id,
    required List<CartItemEntity> cartItems,
    required double totalAmount,
    required DateTime orderDate,
    required String cashierName,
  }) {
    return OrderModel(
      id: id,
      cartItems: cartItems,
      totalAmount: totalAmount,
      orderDate: orderDate,
      cashierName: cashierName,
    );
  }

  toJson() {
    return {
      'id': id,
      'orderItems': cartItems.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'cashierName': cashierName,
    };
  }
}
