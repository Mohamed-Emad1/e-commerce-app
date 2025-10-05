class CartItemModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final String size;
  final String color;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'size': size,
      'color': color,
      'quantity': quantity,
    };
  }




}