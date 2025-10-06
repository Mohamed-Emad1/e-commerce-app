import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';

import 'amount.dart';
import 'item_list.dart';

class PaypalPaymentEntity {
  Amount? amount;
  String? description;
  ItemList? itemList;

  PaypalPaymentEntity({this.amount, this.description, this.itemList});

  factory PaypalPaymentEntity.fromEntity({required CartItemsList entity}) {
    return PaypalPaymentEntity(
      description: "The payment transaction description.",
      amount: Amount.fromEntity(entity: entity),
      itemList: ItemList.fromEntity(entity: entity.items),
    );
  }

  toJson() => {
    'amount': amount?.toJson(),
    'description': description,
    'item_list': itemList?.toJson(),
  };
}
