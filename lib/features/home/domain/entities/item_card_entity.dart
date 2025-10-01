import 'package:flutter/material.dart';

class ItemCardEntity {
  int id;
  String imagePath;
  String title;
  String description;
  double price;
  bool isFavorite;
  String category;
  List<Color> colors;
  List<ItemSize> availableSizes;
  ItemCardEntity({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.isFavorite = false,
    required this.category,
    required this.colors,
    required this.availableSizes,
  }); 
}

enum ItemSize { s, m, l, xl }

extension ItemSizeExtension on ItemSize {
  String get displayName {
    switch (this) {
      case ItemSize.s:
        return 'Small';
      case ItemSize.m:
        return 'Medium';
      case ItemSize.l:
        return 'Large';
      case ItemSize.xl:
        return 'X-Large';
    }
  }

  String get shortName {
    switch (this) {
      case ItemSize.s:
        return 'S';
      case ItemSize.m:
        return 'M';
      case ItemSize.l:
        return 'L';
      case ItemSize.xl:
        return 'XL';
    }
  }
}
