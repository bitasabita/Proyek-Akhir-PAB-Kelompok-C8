class ProductModel {
  final String id;
  final String name;
  final int price;
  final int costPrice;
  final int stock;
  final String? imageUrl;
  final DateTime? createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.costPrice,
    required this.stock,
    this.imageUrl,
    this.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      price: (map['price'] ?? 0) as int,
      costPrice: (map['cost_price'] ?? 0) as int,
      stock: (map['stock'] ?? 0) as int,
      imageUrl: map['image_url'],
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'cost_price': costPrice,
      'stock': stock,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    int? costPrice,
    int? stock,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}