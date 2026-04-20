import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../models/order_item_model.dart';
import '../models/product_model.dart';
import '../services/order_service.dart';
import '../services/payment_proof_service.dart';
import '../services/product_service.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';
import '../utils/input_validators.dart';
import 'camera_capture_page.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  final ProductService _productService = ProductService();
  final OrderService _orderService = OrderService();
  final PaymentProofService _paymentProofService = PaymentProofService();
  final GlobalKey<FormState> _customerFormKey = GlobalKey<FormState>();

  final TextEditingController customerNameController = TextEditingController();

  List<ProductModel> products = [];
  List<OrderItemModel> cart = [];
  bool isLoading = true;
  bool isCheckingOut = false;

  String paymentMethod = 'Tunai';

  final List<String> paymentMethods = [
    'Tunai',
    'QRIS',
    'Transfer',
  ];

  @override
  void initState() {
    super.initState();
    fetchProducts();
    customerNameController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    customerNameController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      products = await _productService.getProducts();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil produk: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  ProductModel? _findProductById(String productId) {
    try {
      return products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  CameraDescription? _pickCamera() {
    if (appCameras.isEmpty) return null;

    try {
      return appCameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
    } catch (_) {
      return appCameras.first;
    }
  }

  Future<XFile?> _openCameraAndCapture() async {
    final selectedCamera = _pickCamera();

    if (selectedCamera == null) {
      if (!mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kamera tidak tersedia di perangkat ini')),
      );
      return null;
    }

    final image = await Navigator.push<XFile>(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCapturePage(camera: selectedCamera),
      ),
    );

    return image;
  }

  void addToCart(ProductModel product) {
    if (product.stock <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stok habis')),
      );
      return;
    }

    final index = cart.indexWhere((e) => e.productId == product.id);

    if (index >= 0) {
      final current = cart[index];

      if (current.quantity >= product.stock) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jumlah melebihi stok')),
        );
        return;
      }

      cart[index] = OrderItemModel(
        productId: current.productId,
        productName: current.productName,
        quantity: current.quantity + 1,
        price: current.price,
        costPrice: current.costPrice,
        subtotal: (current.quantity + 1) * current.price,
      );
    } else {
      cart.add(
        OrderItemModel(
          productId: product.id,
          productName: product.name,
          quantity: 1,
          price: product.price,
          costPrice: product.costPrice,
          subtotal: product.price,
        ),
      );
    }

    setState(() {});
  }

  void increaseQty(OrderItemModel item) {
    final product = _findProductById(item.productId);
    if (product == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk tidak ditemukan')),
      );
      return;
    }

    final index = cart.indexWhere((e) => e.productId == item.productId);

    if (item.quantity >= product.stock) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah melebihi stok')),
      );
      return;
    }

    cart[index] = OrderItemModel(
      productId: item.productId,
      productName: item.productName,
      quantity: item.quantity + 1,
      price: item.price,
      costPrice: item.costPrice,
      subtotal: (item.quantity + 1) * item.price,
    );

    setState(() {});
  }

  void decreaseQty(OrderItemModel item) {
    final index = cart.indexWhere((e) => e.productId == item.productId);

    if (index < 0) return;

    if (item.quantity <= 1) {
      cart.removeAt(index);
    } else {
      cart[index] = OrderItemModel(
        productId: item.productId,
        productName: item.productName,
        quantity: item.quantity - 1,
        price: item.price,
        costPrice: item.costPrice,
        subtotal: (item.quantity - 1) * item.price,
      );
    }

    setState(() {});
  }

  void removeFromCart(OrderItemModel item) {
    cart.removeWhere((e) => e.productId == item.productId);
    setState(() {});
  }

  int get totalPrice => cart.fold(0, (sum, item) => sum + item.subtotal);

  int get totalCost =>
      cart.fold(0, (sum, item) => sum + (item.costPrice * item.quantity));

  int get totalProfit => totalPrice - totalCost;

  String get customerDisplayName {
    return InputValidators.normalizeText(customerNameController.text);
  }

  Future<String> _getCashierName(String userId) async {
    final profile = await Supabase.instance.client
        .from('profiles')
        .select('name')
        .eq('id', userId)
        .maybeSingle();

    if (profile == null) return 'Kasir';
    return (profile['name'] ?? 'Kasir') as String;
  }

  Future<void> showSuccessDialog({required bool hasProof}) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: AppColors.success,
                size: 42,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pesanan Berhasil Disimpan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasProof
                  ? 'Transaksi dan bukti pembayaran berhasil disimpan.'
                  : 'Transaksi telah masuk ke riwayat dan laporan penjualan.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Oke'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateCheckout() {
    final isCustomerValid =
        _customerFormKey.currentState?.validate() ?? false;
    if (!isCustomerValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama pelanggan wajib valid')),
      );
      return false;
    }

    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang masih kosong')),
      );
      return false;
    }

    if (paymentMethod.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Metode pembayaran wajib dipilih')),
      );
      return false;
    }

    for (final item in cart) {
      if (item.quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Jumlah item ${item.productName} tidak valid'),
          ),
        );
        return false;
      }

      final product = _findProductById(item.productId);
      if (product == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produk ${item.productName} tidak ditemukan'),
          ),
        );
        return false;
      }

      if (item.quantity > product.stock) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Jumlah ${item.productName} melebihi stok tersedia',
            ),
          ),
        );
        return false;
      }
    }

    return true;
  }

  Future<void> checkout() async {
    if (isCheckingOut) return;

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sesi login tidak ditemukan')),
      );
      return;
    }

    final isValid = _validateCheckout();
    if (!isValid) return;

    setState(() => isCheckingOut = true);

    try {
      final cashierName = await _getCashierName(user.id);

      XFile? proofImage;
      final requiresProof = _paymentProofService.requiresProof(paymentMethod);

      if (requiresProof) {
        proofImage = await _openCameraAndCapture();

        if (proofImage == null) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Bukti pembayaran wajib diambil untuk pembayaran online',
              ),
            ),
          );
          setState(() => isCheckingOut = false);
          return;
        }
      }

      final orderId = await _orderService.createOrder(
        userId: user.id,
        customerName: customerDisplayName,
        paymentMethod: paymentMethod,
        cashierName: cashierName,
        items: cart,
        totalPrice: totalPrice,
        totalCost: totalCost,
        totalProfit: totalProfit,
      );

      if (proofImage != null) {
        final proofUrl = await _paymentProofService.uploadProof(
          orderId: orderId,
          imageFile: proofImage,
        );

        await _orderService.savePaymentProof(
          orderId: orderId,
          proofUrl: proofUrl,
        );
      }

      cart.clear();
      customerNameController.clear();
      paymentMethod = 'Tunai';

      await fetchProducts();

      if (!mounted) return;
      setState(() {});

      await showSuccessDialog(hasProof: proofImage != null);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal checkout: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isCheckingOut = false);
      }
    }
  }

  Widget _headerCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
            'Kasir',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Buat pesanan pelanggan dan simpan transaksi dengan cepat.',
            style: TextStyle(
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerSection() {
    final requiresProof = _paymentProofService.requiresProof(paymentMethod);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _customerFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: customerNameController,
              textInputAction: TextInputAction.next,
              inputFormatters: InputValidators.customerNameInputFormatters(),
              validator: InputValidators.validateCustomerName,
              decoration: const InputDecoration(
                labelText: 'Nama Pelanggan',
                hintText:
                    'Wajib diisi. Huruf dan angka boleh, tidak boleh angka semua',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              value: paymentMethod,
              decoration: const InputDecoration(
                labelText: 'Metode Pembayaran',
                prefixIcon: Icon(Icons.payments_outlined),
              ),
              items: paymentMethods
                  .map(
                    (method) => DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    ),
                  )
                  .toList(),
              onChanged: isCheckingOut
                  ? null
                  : (value) {
                      if (value == null) return;
                      setState(() {
                        paymentMethod = value;
                      });
                    },
            ),
            if (requiresProof) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt_outlined, color: Colors.orange),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Pembayaran online wajib foto bukti pembayaran dari kamera saat simpan pesanan.',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _productImage(ProductModel product) {
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          product.imageUrl!,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.fastfood_outlined,
                color: AppColors.primary,
              ),
            );
          },
        ),
      );
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.fastfood_outlined,
        color: AppColors.primary,
      ),
    );
  }

  Widget _productCard(ProductModel product) {
    final outOfStock = product.stock <= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
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
                const SizedBox(height: 6),
                Text(
                  CurrencyFormatter.rupiah(product.price),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  outOfStock ? 'Stok habis' : 'Stok: ${product.stock}',
                  style: TextStyle(
                    color: outOfStock
                        ? AppColors.danger
                        : AppColors.textSecondary,
                    fontWeight: outOfStock ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: isCheckingOut || outOfStock ? null : () => addToCart(product),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: outOfStock || isCheckingOut
                    ? AppColors.textSecondary.withOpacity(0.3)
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartItem(OrderItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  CurrencyFormatter.rupiah(item.price),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: isCheckingOut ? null : () => decreaseQty(item),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            onPressed: isCheckingOut ? null : () => increaseQty(item),
            icon: const Icon(Icons.add_circle_outline),
          ),
          IconButton(
            onPressed: isCheckingOut ? null : () => removeFromCart(item),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }

  Widget _cartSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Ringkasan Pesanan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${cart.length} item',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (cart.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Belum ada item di keranjang',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          else
            ...cart.map(_cartItem),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pelanggan',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Flexible(
                child: Text(
                  customerDisplayName.isEmpty ? '-' : customerDisplayName,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pembayaran',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              Text(
                paymentMethod,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total Pesanan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  CurrencyFormatter.rupiah(totalPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isCheckingOut ? null : checkout,
              child: isCheckingOut
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Simpan Pesanan'),
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
        title: const Text('Kasir'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                _headerCard(),
                _customerSection(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: products.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Text(
                              'Belum ada produk',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: products.map(_productCard).toList(),
                        ),
                ),
                _cartSection(),
              ],
            ),
    );
  }
}