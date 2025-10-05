import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

class HomeCardEntityList extends ChangeNotifier {
  final List<ItemCardEntity> _items = [];

  List<ItemCardEntity> get items => List.unmodifiable(_items);

  bool isFavorite(ItemCardEntity item) {
    // log('------------------');
    log(item.id.toString());
    for (var favItem in _items) {
      if (favItem.isFavorite) {
        // log("id is  = " + favItem.id.toString());
        // log('------------------');
        // log(favItem.isFavorite.toString());
        return true;
      }
    }
    return false;
  }

  void toggleFavorite(ItemCardEntity item) {
    // Find the item in the list by id
    int index = _items.indexWhere((favItem) => favItem.id == item.id);
    log(item.isFavorite.toString());
    // log(index.toString());
    if (index != -1) {
      //! TODO: update database
      // Item exists in list, toggle its favorite status
      _items[index].isFavorite = !_items[index].isFavorite;
    } else {
      // Item doesn't exist in list, add it with favorite = true
      item.isFavorite = true;
      _items.add(item);
    }
    log(item.isFavorite.toString());

    notifyListeners();
  }

  // void addToFavorites(ItemCardEntity item) {
  //   if (!isFavorite(item)) {
  //     _items.add(item);
  //   }
  //   notifyListeners(); // This is key!
  // }

  void removeFromFavorites(ItemCardEntity item) {
    if (isFavorite(item)) {
      _items.removeWhere((favItem) => favItem.title == item.title);
    }
    notifyListeners(); // This is key!
  }

  void clearList() {
    _items.clear();
    notifyListeners(); // This is key!
  }

  addToItems(List<ItemCardEntity> products) {
    _items.addAll(products);
    notifyListeners(); // This is key!
  }
}
