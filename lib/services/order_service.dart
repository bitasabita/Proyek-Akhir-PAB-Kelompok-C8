import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_item_model.dart';

class OrderService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String> createOrder({
    required String userId,
    required String customerName,
    required String paymentMethod,
    required String cashierName,
    required List<OrderItemModel> items,
    required int totalPrice,
    required int totalCost,
    required int totalProfit,
  }) async {
    final order = await _client
        .from('orders')
        .insert({
          'user_id': userId,
          'customer_name': customerName,
          'payment_method': paymentMethod,
          'cashier_name': cashierName,
          'total_price': totalPrice,
          'total_cost': totalCost,
          'total_profit': totalProfit,
        })
        .select()
        .single();

    final orderId = order['id'].toString();

    for (final item in items) {
      await _client.from('order_items').insert(item.toJson(orderId));

      final product = await _client
          .from('products')
          .select()
          .eq('id', item.productId)
          .single();

      final currentStock = product['stock'] as int;
      final newStock = currentStock - item.quantity;

      await _client
          .from('products')
          .update({'stock': newStock})
          .eq('id', item.productId);

      await _client.from('stock_logs').insert({
        'product_id': item.productId,
        'type': 'out',
        'quantity': item.quantity,
        'note': 'Pengurangan stok dari transaksi',
      });
    }

    return orderId;
  }

  Future<void> savePaymentProof({
    required String orderId,
    required String proofUrl,
  }) async {
    await _client.from('orders').update({
      'payment_proof_url': proofUrl,
      'payment_proof_uploaded_at': DateTime.now().toIso8601String(),
    }).eq('id', orderId);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final response = await _client
        .from('orders')
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getOrderItems(String orderId) async {
    final response = await _client
        .from('order_items')
        .select()
        .eq('order_id', orderId)
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }
}