import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kshk/features/home/domain/entities/item_card_entity.dart';

final List<ItemCardEntity> dummyItems = [
  ItemCardEntity(
    id: 1,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Classic Cotton T-Shirt',
    description: 'Comfortable cotton t-shirt perfect for everyday wear',
    price: 29.99,
    isFavorite: false,
    category: 'T-Shirts',
    colors: [Colors.blue, Colors.black, Colors.white],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l, ItemSize.xl],
  ),
  ItemCardEntity(
    id: 2,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Slim Fit Jeans',
    description: 'Modern slim fit jeans with stretch denim',
    price: 59.99,
    isFavorite: true,
    category: 'Pants',
    colors: [Colors.blue.shade800, Colors.black],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l],
  ),
  ItemCardEntity(
    id: 2,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Pullover Hoodie',
    description: 'Cozy fleece hoodie with kangaroo pocket',
    price: 49.99,
    isFavorite: false,
    category: 'Hoodies',
    colors: [Colors.grey, Colors.black, Colors.red],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l],
  ),
  ItemCardEntity(
    id: 3,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Running Sneakers',
    description: 'Lightweight running shoes with cushioned sole',
    price: 89.99,
    isFavorite: true,
    category: 'Shoes',
    colors: [Colors.white, Colors.grey.shade300],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l],
  ),
  ItemCardEntity(
    id: 4,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Denim Jacket',
    description: 'Classic denim jacket with button closure',
    price: 79.99,
    isFavorite: false,
    category: 'Jackets',
    colors: [Colors.blue.shade700, Colors.black],
    availableSizes: [ItemSize.m, ItemSize.l],
  ),
  ItemCardEntity(
    id: 5,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Summer Dress',
    description: 'Flowy summer dress with floral pattern',
    price: 44.99,
    isFavorite: true,
    category: 'Dresses',
    colors: [
      Colors.pink.shade200,
      Colors.purple.shade200,
      Colors.yellow.shade100,
    ],
    availableSizes: [ItemSize.s],
  ),
  ItemCardEntity(
    id: 6,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Cargo Shorts',
    description: 'Comfortable cargo shorts with multiple pockets',
    price: 34.99,
    isFavorite: false,
    category: 'Shorts',
    colors: [Colors.brown.shade300, Colors.green.shade700, Colors.grey],
    availableSizes: [ItemSize.s, ItemSize.m],
  ),
  ItemCardEntity(
    id: 7,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Knit Sweater',
    description: 'Warm knit sweater for cold weather',
    price: 54.99,
    isFavorite: false,
    category: 'Sweaters',
    colors: [Colors.brown, Colors.grey.shade700, Colors.blue.shade900],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l],
  ),
  ItemCardEntity(
    id: 8,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Baseball Cap',
    description: 'Adjustable baseball cap with embroidered logo',
    price: 19.99,
    isFavorite: true,
    category: 'Accessories',
    colors: [Colors.black, Colors.red, Colors.blue],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l],
  ),
  ItemCardEntity(
    id: 9,
    imagePath: 'assets/images/onboarding_first.png',
    title: 'Travel Backpack',
    description: 'Spacious backpack with laptop compartment',
    price: 69.99,
    isFavorite: false,
    category: 'Bags',
    colors: [Colors.black, Colors.grey, Colors.blue.shade900],
    availableSizes: [ItemSize.s, ItemSize.m, ItemSize.l],
  ),
];

Future<void> uploadDummyItems() async {
  final firestore = FirebaseFirestore.instance;

  for (var item in dummyItems.take(2)) {
    // First 2 items
    await firestore.collection('products').add({
      'id': item.id,
      'imagePath': item.imagePath,
      'title': item.title,
      'description': item.description,
      'price': item.price,
      'isFavorite': item.isFavorite,
      'category': item.category,
      'colors': item.colors
          .map((c) => '0x${c.value.toRadixString(16).toUpperCase()}')
          .toList(),
      'availableSizes': item.availableSizes.map((s) => s.name).toList(),
    });
  }
}
