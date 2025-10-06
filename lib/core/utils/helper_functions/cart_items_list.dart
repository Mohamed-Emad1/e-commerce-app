import 'package:flutter/material.dart';
import 'package:kshk/core/utils/entities/cart_item_entity.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

class CartItemsList extends ChangeNotifier {
  final List<CartItemEntity> _items = [];

  List<CartItemEntity> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  // double get subtotal => _items.fold(0, (sum, item) => sum + item.price);

  void addItem(ItemCardEntity item, String size, String color) {
    // item.colors.add(color);
    // item.availableSizes.add(size);
    _items.add(
      CartItemEntity(
        id: item.id.toString(),
        name: item.title,
        price: item.price,
        image: item.imagePath,
        color: color,
        size: size,
        quantity: 1,
      ),
    );

    notifyListeners();
  }

  void increaseQuantity(CartItemEntity item) {
    int index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity += 1;
    }
    notifyListeners();
  }

  int getQuantity(CartItemEntity item) {
    int index = _items.indexOf(item);
    if (index != -1) {
      return _items[index].quantity;
    }
    return 0;
  }

  void decreaseQuantity(CartItemEntity item) {
    int index = _items.indexOf(item);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
        notifyListeners();
      } else {
        removeItem(item);
      }
    }
  }

  void removeItem(CartItemEntity item) {
    _items.remove(item);
    notifyListeners();
  }

  List getItems() {
    return _items;
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    // notifyListeners();
    return total;
  }
}
