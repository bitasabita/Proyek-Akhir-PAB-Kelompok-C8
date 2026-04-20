import 'package:supabase_flutter/supabase_flutter.dart';

class ReportService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Map<String, dynamic>> getDashboardSummary() async {
    final ordersResponse = await _client.from('orders').select();
    final orderItemsResponse = await _client.from('order_items').select();

    final orders = List<Map<String, dynamic>>.from(ordersResponse);
    final orderItems = List<Map<String, dynamic>>.from(orderItemsResponse);

    int omzet = 0;
    int profit = 0;
    int totalItemsOut = 0;

    for (final order in orders) {
      omzet += (order['total_price'] ?? 0) as int;
      profit += (order['total_profit'] ?? 0) as int;
    }

    final Map<String, int> productCount = {};

    for (final item in orderItems) {
      final qty = (item['quantity'] ?? 0) as int;
      final productName = (item['product_name'] ?? '-') as String;

      totalItemsOut += qty;
      productCount[productName] = (productCount[productName] ?? 0) + qty;
    }

    String bestSeller = '-';
    int bestSellerQty = 0;

    productCount.forEach((product, qty) {
      if (qty > bestSellerQty) {
        bestSellerQty = qty;
        bestSeller = product;
      }
    });

    final sortedProductSales = productCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final productSalesList = sortedProductSales
        .map(
          (e) => {
            'product_name': e.key,
            'qty': e.value,
          },
        )
        .toList();

    return {
      'omzet': omzet,
      'profit': profit,
      'totalItemsOut': totalItemsOut,
      'bestSeller': bestSeller,
      'bestSellerQty': bestSellerQty,
      'productSales': productSalesList,
    };
  }

  Future<List<Map<String, dynamic>>> getRecentOrders() async {
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

  Future<List<Map<String, dynamic>>> getMonthlySales({
    int monthCount = 6,
  }) async {
    final response = await _client
        .from('orders')
        .select('created_at, total_profit')
        .order('created_at', ascending: true);

    final orders = List<Map<String, dynamic>>.from(response);

    final now = DateTime.now();
    final List<DateTime> months = List.generate(
      monthCount,
      (index) => DateTime(now.year, now.month - (monthCount - 1 - index), 1),
    );

    final Map<String, int> monthlyTotals = {
      for (final month in months) _monthKey(month): 0,
    };

    for (final order in orders) {
      final createdAtRaw = order['created_at'];
      if (createdAtRaw == null) continue;

      final createdAt = DateTime.tryParse(createdAtRaw.toString());
      if (createdAt == null) continue;

      final key = _monthKey(DateTime(createdAt.year, createdAt.month, 1));
      if (monthlyTotals.containsKey(key)) {
        monthlyTotals[key] =
            (monthlyTotals[key] ?? 0) + ((order['total_profit'] ?? 0) as int);
      }
    }

    return months.map((month) {
      final key = _monthKey(month);
      return {
        'label': _monthLabel(month.month),
        'value': monthlyTotals[key] ?? 0,
      };
    }).toList();
  }

  String _monthKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }

  String _monthLabel(int month) {
    const labels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return labels[month - 1];
  }
}