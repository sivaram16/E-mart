class CartItemModel {
  final String name;
  final String id;
  final double price;
  final double perUnitPrice;
  final String unit;
  final String category;

  CartItemModel(
      {this.name,
      this.id,
      this.price,
      this.perUnitPrice,
      this.unit,
      this.category});

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
      name: json['name'],
      id: json['id'],
      price: json['price'],
      perUnitPrice: json['perUnitPrice'],
      unit: json['unit'],
      category: json['category'],
    );
  }
}
