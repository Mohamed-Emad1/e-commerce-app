import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/entities/cart_item_entity.dart';

class ItemEntity {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  ItemEntity({this.name, this.quantity, this.price, this.currency});

  // Map<String, dynamic> toMap() => {
  //   'name': name,
  //   'quantity': quantity,
  //   'price': price,
  //   'currency': currency,
  // };

  // /// `dart:convert`
  // ///
  // /// Converts [ItemEntity] to a JSON string.
  // String toJson() => json.encode(toMap());
  toJson() => {
    'name': name,
    'quantity': quantity,
    'price': price,
    'currency': currency,
  };

  factory ItemEntity.fromEntity({required CartItemEntity entity}) {
    return ItemEntity(
      name: entity.name,
      quantity: entity.quantity,
      price: entity.price.toString(),
      currency: kUsdCurrency,
    );
  }
}
