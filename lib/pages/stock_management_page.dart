import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import '../theme/app_colors.dart';
import '../utils/input_validators.dart';

class StockManagementPage extends StatefulWidget {
  const StockManagementPage({super.key});

  @override
  State<StockManagementPage> createState() => _StockManagementPageState();
}

class _StockManagementPageState extends State<StockManagementPage> {
  final ProductService _service = ProductService();
  final TextEditingController _searchController = TextEditingController();

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  bool isLoading = true;

  String selectedFilter = 'Semua';

  final List<String> stockFilters = [
    'Semua',
    'Stok Menipis',
    'Stok Habis',
  ];

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      products = await _service.getProducts();
      _applyFilters();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data stok: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase().trim();

    final result = products.where((product) {
      final matchSearch = product.name.toLowerCase().contains(query);

      bool matchStockFilter = true;

      if (selectedFilter == 'Stok Menipis') {
        matchStockFilter = product.stock > 0 && product.stock < 15;
      } else if (selectedFilter == 'Stok Habis') {
        matchStockFilter = product.stock <= 0;
      }

      return matchSearch && matchStockFilter;
    }).toList();

    setState(() {
      filteredProducts = result;
    });
  }

  Future<void> updateStockDialog(ProductModel product) async {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController(text: product.stock.toString());
    bool isSaving = false;

    await showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setModalState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text('Update Stok ${product.name}'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              validator: InputValidators.validateStock,
              keyboardType: TextInputType.number,
              inputFormatters: InputValidators.stockInputFormatters(),
              decoration: const InputDecoration(
                labelText: 'Stok Baru',
                hintText: 'Hanya angka. Maksimal 3000',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSaving ? null : () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: isSaving
                  ? null
                  : () async {
                      final isValid = formKey.currentState?.validate() ?? false;
                      if (!isValid) return;

                      final stock = int.parse(controller.text.trim());

                      final isConfirmed = await showDialog<bool>(
                        context: dialogContext,
                        builder: (confirmContext) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          title: const Text('Konfirmasi'),
                          content: Text(
                            'Apakah Anda ingin memperbarui stok ${product.name} menjadi $stock?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(confirmContext, false),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(confirmContext, true),
                              child: const Text('Ya'),
                            ),
                          ],
                        ),
                      );

                      if (isConfirmed != true) return;

                      setModalState(() => isSaving = true);

                      try {
                        await _service.updateStock(
                          id: product.id,
                          stock: stock,
                        );

                        if (!mounted) return;
                        Navigator.pop(dialogContext);
                        await fetchProducts();

                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Stok berhasil diperbarui'),
                          ),
                        );
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal update stok: $e')),
                        );
                      } finally {
                        if (dialogContext.mounted) {
                          setModalState(() => isSaving = false);
                        }
                      }
                    },
              child: isSaving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  Color _stockColor(int stock) {
    if (stock <= 0) return AppColors.danger;
    if (stock < 15) return Colors.orange;
    return AppColors.success;
  }

  String _stockLabel(int stock) {
    if (stock <= 0) return 'Stok habis';
    if (stock < 15) return 'Stok menipis: $stock';
    return 'Stok saat ini: $stock';
  }

  Widget _productImage(ProductModel product) {
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          product.imageUrl!,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: AppColors.primary,
              ),
            );
          },
        ),
      );
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.inventory_2_outlined,
        color: AppColors.primary,
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
            'Manajemen Stok',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Pantau stok produk, cari barang lebih cepat, dan lihat stok menipis atau habis.',
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
        hintText: 'Cari nama produk',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _filterChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: stockFilters.map((filter) {
        final isSelected = selectedFilter == filter;

        return ChoiceChip(
          label: Text(filter),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              selectedFilter = filter;
            });
            _applyFilters();
          },
        );
      }).toList(),
    );
  }

  Widget _stockCard(ProductModel product) {
    final stockColor = _stockColor(product.stock);

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productImage(product),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: stockColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _stockLabel(product.stock),
                    style: TextStyle(
                      color: stockColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => updateStockDialog(product),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
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
            Icons.inventory_2_outlined,
            size: 72,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 14),
          Text(
            'Tidak ada data stok',
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
        title: const Text('Stok'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchProducts,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(),
            const SizedBox(height: 18),
            _searchBox(),
            const SizedBox(height: 12),
            _filterChips(),
            const SizedBox(height: 18),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (filteredProducts.isEmpty)
              _emptyState()
            else
              ...filteredProducts.map(_stockCard),
          ],
        ),
      ),
    );
  }
}