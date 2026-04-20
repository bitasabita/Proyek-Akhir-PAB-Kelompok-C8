class OrderItemModel {
  final String productId;
  final String productName;
  final int quantity;
  final int price;
  final int costPrice;
  final int subtotal;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.costPrice,
    required this.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'] as String,
      productName: (json['product_name'] ?? '') as String,
      quantity: (json['quantity'] ?? 0) as int,
      price: (json['price'] ?? 0) as int,
      costPrice: (json['cost_price'] ?? 0) as int,
      subtotal: (json['subtotal'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson(String orderId) {
    return {
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
      'cost_price': costPrice,
      'subtotal': subtotal,
    };
  }
}