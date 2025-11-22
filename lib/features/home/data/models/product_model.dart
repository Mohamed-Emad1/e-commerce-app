import 'package:flutter/material.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.colors,
    required this.availableSizes,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final String imagePath;
  final String category;
  final List<String> colors;
  final List<String> availableSizes;
  final bool isFavorite;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      isFavorite: json['isFavorite'] as bool? ?? false,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imagePath: json['imagePath'] as String,
      category: json['category'] as String,
      colors: List<String>.from(json['colors'] ?? []),
      availableSizes: List<String>.from(json['availableSizes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isFavorite': isFavorite,
      'title': title,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'category': category,
      'colors': colors,
      'availableSizes': availableSizes,
    };
  }

  ItemCardEntity toEntity() {
    return ItemCardEntity(
      id: int.tryParse(id) ?? 0,
      title: title,
      description: description,
      price: price,
      imagePath: imagePath,
      category: category,
      isFavorite: isFavorite,
      colors: colors.map((hex) => _parseColor(hex)).toList(),
      availableSizes: availableSizes.map((size) => _parseSize(size)).toList(),
    );
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor));
    } catch (e) {
      return Colors.grey;
    }
  }

  // Parse size string to ItemSize enum
  ItemSize _parseSize(String size) {
    switch (size.toLowerCase()) {
      case 's':
        return ItemSize.s;
      case 'm':
        return ItemSize.m;
      case 'l':
        return ItemSize.l;
      case 'xl':
        return ItemSize.xl;
      default:
        return ItemSize.m;
    }
  }

  // Helper method to create ProductModel from ItemCardEntity
  factory ProductModel.fromEntity(ItemCardEntity entity) {
    return ProductModel(
      id: entity.id.toString(),
      title: entity.title,
      isFavorite: entity.isFavorite,
      description: entity.description,
      price: entity.price,
      imagePath: entity.imagePath,
      category: entity.category,
      colors: entity.colors.map((color) {
        final hexString = color.toARGB32().toRadixString(16).toUpperCase();
        return '0x$hexString';
      }).toList(),
      availableSizes: entity.availableSizes
          .map((size) => size.name.toLowerCase())
          .toList(),
    );
  }
}
