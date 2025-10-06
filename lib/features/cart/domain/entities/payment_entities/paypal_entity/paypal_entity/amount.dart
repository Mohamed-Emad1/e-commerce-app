import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/core/utils/helper_functions/cart_items_list.dart';

import 'details.dart';

class Amount {
  String? total;
  String? currency;
  Details? details;

  Amount({this.total, this.currency, this.details});

  factory Amount.fromEntity({required CartItemsList entity}) => Amount(
    total: (entity.getTotalPrice() - kShippingDiscount + kShippingCost)
        .toString(),
    currency: kCurrency,
    details: Details.fromEntity(entity),
  );

  toJson() => {
    'total': total,
    'currency': currency,
    'details': details?.toJson(),
  };
}
