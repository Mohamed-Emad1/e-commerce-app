import 'package:kshk/core/utils/entities/cart_item_entity.dart';

import 'item.dart';

class ItemList {
  List<ItemEntity>? items;

  ItemList({this.items});

  factory ItemList.fromEntity({required List<CartItemEntity> entity}) {
    return ItemList(
      items: entity.map((e) => ItemEntity.fromEntity(entity: e)).toList(),
    );
  }

  toJson() => {
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
