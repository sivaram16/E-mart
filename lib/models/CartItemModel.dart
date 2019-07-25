class CartItemModel {
  final String name;
  final String id;
  final double price;
  final String unit;
  final String category;

  CartItemModel({this.name, this.id, this.price, this.unit, this.category});

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
      name: json['name'],
      id: json['id'],
      price: json['price'].toDouble(),
      unit: json['unit'],
      category: json['category'],
    );
  }
}
