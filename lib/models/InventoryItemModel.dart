class InventoryItemModel {
  final String name;
  final String id;
  final double price;
  final double perUnit;
  final String unit;
  final String category;
  final double inStock;
  final String photoUrl;

  InventoryItemModel({this.name, this.id, this.price, this.perUnit, this.unit, this.category, this.inStock, this.photoUrl});

  factory InventoryItemModel.fromJson(Map<dynamic, dynamic> json) {
    return InventoryItemModel(
      name: json['name'],
      id: json['id'],
      price: json['price'],
      perUnit: json['perUnit'],
      unit: json['unit'],
      category: json['category'],
      inStock: json['inStock'],
      photoUrl: json['photoUrl']
    );
  }

  
}