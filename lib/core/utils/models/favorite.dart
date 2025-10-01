import 'package:flutter/foundation.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

class FavoriteService extends ChangeNotifier {
  final List<ItemCardEntity> _items = [];

  List<ItemCardEntity> get items => List.unmodifiable(_items);

  bool isFavorite(ItemCardEntity item) {
    return _items.any((favItem) => favItem.title == item.title);
  }

  void toggleFavorite(ItemCardEntity item) {
    if (isFavorite(item)) {
      _items.removeWhere((favItem) => favItem.title == item.title);
    } else {
      _items.add(item);
    }
    notifyListeners(); // This is key!
  }
}
