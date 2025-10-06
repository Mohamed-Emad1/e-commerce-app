import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';

class Details {
  String? subtotal;
  String? shipping;
  int? shippingDiscount;

  Details({this.subtotal, this.shipping, this.shippingDiscount});

  // Map<String, dynamic> toMap() => {
  //   'subtotal': subtotal,
  //   'shipping': shipping,
  //   'shipping_discount': shippingDiscount,
  // };

  // /// `dart:convert`
  // ///
  // /// Converts [Details] to a JSON string.
  // String toJson() => json.encode(toMap());

  toJson() => {
    'subtotal': subtotal,
    'shipping': shipping,
    'shipping_discount': shippingDiscount,
  };

  factory Details.fromEntity(CartItemsList entity) => Details(
    subtotal: entity.getTotalPrice().toStringAsFixed(
      2,
    ),
    shipping: kShippingCost.toStringAsFixed(2),
    shippingDiscount: kShippingDiscount.toInt(),
  );
}
