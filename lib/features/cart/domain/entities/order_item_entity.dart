// import 'package:kshk/core/utils/entities/cart_item_entity.dart';

// class OrderItemEntity {
//   final CartItemEntity cartItem;
//   final String orderId;
//   final DateTime orderDate;
//   final String cashierName;

//   OrderItemEntity({
//     required this.cartItem,
//     required this.orderId,
//     required this.orderDate,
//     required this.cashierName,
//   });

//   factory OrderItemEntity.fromCartItem({
//     required CartItemEntity cartItem,
//     required String orderId,
//     required DateTime orderDate,
//     required String cashierName,
//   }) {
//     return OrderItemEntity(
//       cartItem: cartItem,
//       orderId: orderId,
//       orderDate: orderDate,
//       cashierName: cashierName,
//     );
//   }

//   toJson() {
//     return {
//       'cartItem': cartItem.toJson(),
//       'orderId': orderId,
//       'orderDate': orderDate.toIso8601String(),
//       'cashierName': cashierName,
//     };
//   }
// }
