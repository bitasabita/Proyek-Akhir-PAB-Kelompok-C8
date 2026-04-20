import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final SupabaseClient _client = Supabase.instance.client;
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> filteredOrders = [];

  bool isLoading = true;
  String userRole = '';

  String selectedPeriod = 'Bulan Ini';
  String selectedPaymentMethod = 'Semua';

  final List<String> periodFilters = [
    'Semua',
    'Hari Ini',
    'Minggu Ini',
    'Bulan Ini',
  ];

  final List<String> paymentFilters = [
    'Semua',
    'Tunai',
    'QRIS',
    'Transfer',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_applyFilters);
    fetchTransactionHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchTransactionHistory() async {
    setState(() => isLoading = true);

    try {
      final user = _client.auth.currentUser;

      if (user == null) {
        throw Exception('User tidak ditemukan');
      }

      final profile = await _client
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .maybeSingle();

      userRole = (profile?['role'] ?? '').toString();

      final response = await _client
          .from('orders')
          .select()
          .order('created_at', ascending: false);

      orders = List<Map<String, dynamic>>.from(response);
      _applyFilters();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil riwayat transaksi: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase().trim();
    final now = DateTime.now();

    final result = orders.where((order) {
      final customerName =
          (order['customer_name'] ?? '').toString().toLowerCase();
      final cashierName = (order['cashier_name'] ?? '').toString().toLowerCase();
      final paymentMethod =
          (order['payment_method'] ?? '').toString().toLowerCase();

      final createdAtRaw = order['created_at'];
      final createdAt = createdAtRaw != null
          ? DateTime.tryParse(createdAtRaw.toString())?.toLocal()
          : null;

      final matchSearch =
          customerName.contains(query) ||
          cashierName.contains(query) ||
          paymentMethod.contains(query);

      bool matchPeriod = true;
      if (createdAt != null) {
        if (selectedPeriod == 'Hari Ini') {
          matchPeriod =
              createdAt.year == now.year &&
              createdAt.month == now.month &&
              createdAt.day == now.day;
        } else if (selectedPeriod == 'Minggu Ini') {
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(Duration(days: now.weekday - 1));

          final endOfWeek = startOfWeek.add(const Duration(days: 7));

          matchPeriod =
              !createdAt.isBefore(startOfWeek) &&
              createdAt.isBefore(endOfWeek);
        } else if (selectedPeriod == 'Bulan Ini') {
          matchPeriod =
              createdAt.year == now.year && createdAt.month == now.month;
        }
      }

      bool matchPayment = true;
      if (selectedPaymentMethod != 'Semua') {
        matchPayment = paymentMethod == selectedPaymentMethod.toLowerCase();
      }

      return matchSearch && matchPeriod && matchPayment;
    }).toList();

    setState(() {
      filteredOrders = result;
    });
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return '-';

    final date = DateTime.tryParse(value)?.toLocal();
    if (date == null) return '-';

    return DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(date);
  }

  int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  void _showProofImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(dialogContext).size.height * 0.85,
            maxWidth: 700,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Bukti Pembayaran',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: double.infinity,
                      color: AppColors.background,
                      child: InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 4,
                        child: Center(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: Text('Gagal memuat gambar'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            color: AppColors.shadow,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Transaksi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Lihat seluruh transaksi, cari lebih cepat, dan filter berdasarkan periode atau pembayaran.',
            style: TextStyle(
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Cari pelanggan, kasir, atau pembayaran',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _periodFilterChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: periodFilters.map((filter) {
        return ChoiceChip(
          label: Text(filter),
          selected: selectedPeriod == filter,
          onSelected: (_) {
            setState(() {
              selectedPeriod = filter;
            });
            _applyFilters();
          },
        );
      }).toList(),
    );
  }

  Widget _paymentDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedPaymentMethod,
      decoration: const InputDecoration(
        labelText: 'Filter Pembayaran',
        prefixIcon: Icon(Icons.payments_outlined),
      ),
      items: paymentFilters.map((method) {
        return DropdownMenuItem<String>(
          value: method,
          child: Text(method),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          selectedPaymentMethod = value;
        });
        _applyFilters();
      },
    );
  }

  Widget _summaryCard() {
    final totalTransactions = filteredOrders.length;
    final totalRevenue = filteredOrders.fold<int>(
      0,
      (sum, item) => sum + _toInt(item['total_price']),
    );

    if (userRole == 'employee') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: AppColors.shadow,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              const Text(
                'Jumlah Transaksi',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$totalTransactions',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text(
                    'Jumlah Transaksi',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$totalTransactions',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Text(
                    'Total Omset',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    CurrencyFormatter.rupiah(totalRevenue),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionCard(Map<String, dynamic> order) {
    final customerName =
        (order['customer_name'] ?? 'Pelanggan Umum').toString();
    final cashierName = (order['cashier_name'] ?? '-').toString();
    final paymentMethod = (order['payment_method'] ?? '-').toString();
    final totalPrice = _toInt(order['total_price']);
    final createdAt = _formatDate(order['created_at']?.toString());
    final proofUrl = (order['payment_proof_url'] ?? '').toString();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  customerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  paymentMethod,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _infoRow('Kasir', cashierName),
          const SizedBox(height: 8),
          _infoRow('Waktu', createdAt),
          const SizedBox(height: 8),
          _infoRow(
            'Total',
            CurrencyFormatter.rupiah(totalPrice),
            isBold: true,
          ),
          if (proofUrl.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Bukti Pembayaran',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showProofImage(proofUrl),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      proofUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text('Gagal memuat bukti pembayaran'),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Klik untuk perbesar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Text(': '),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.history,
            size: 72,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 14),
          Text(
            'Tidak ada riwayat transaksi',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchTransactionHistory,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(),
            const SizedBox(height: 18),
            _searchBox(),
            const SizedBox(height: 12),
            _periodFilterChips(),
            const SizedBox(height: 12),
            _paymentDropdown(),
            const SizedBox(height: 18),
            if (!isLoading) _summaryCard(),
            const SizedBox(height: 18),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (filteredOrders.isEmpty)
              _emptyState()
            else
              ...filteredOrders.map(_transactionCard),
          ],
        ),
      ),
    );
  }
}