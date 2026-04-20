import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';
import '../utils/input_validators.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() =>
      _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final ProductService _service = ProductService();
  List<ProductModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() => isLoading = true);
    try {
      products = await _service.getProducts();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil produk: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<(Uint8List?, String?)> pickImageFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return (null, null);
      }

      final file = result.files.single;

      if (file.bytes == null) {
        throw Exception('File gambar tidak terbaca');
      }

      return (file.bytes!, file.name);
    } catch (e) {
      if (!mounted) return (null, null);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih gambar: $e')),
      );
      return (null, null);
    }
  }

  Future<void> showProductDialog({ProductModel? product}) async {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController(
      text: product?.name ?? '',
    );
    final priceController = TextEditingController(
      text: product != null ? product.price.toString() : '',
    );
    final costPriceController = TextEditingController(
      text: product != null ? product.costPrice.toString() : '',
    );
    final stockController = TextEditingController(
      text: product != null ? product.stock.toString() : '',
    );

    Uint8List? selectedImageBytes;
    String? selectedImageName;
    String? currentImageUrl = product?.imageUrl;
    bool isSaving = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setModalState) {
            Widget imagePreview() {
              if (selectedImageBytes != null) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.memory(
                    selectedImageBytes!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              size: 48,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Preview gambar gagal ditampilkan',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              if (currentImageUrl != null && currentImageUrl!.isNotEmpty) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    currentImageUrl!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              size: 48,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Gambar produk tidak bisa dimuat',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              return Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Belum ada gambar',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Dialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 480,
                  maxHeight: 760,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          product == null
                              ? 'Tambah Produk'
                              : 'Edit Produk',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        imagePreview(),
                        if (selectedImageName != null &&
                            selectedImageName!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            selectedImageName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: isSaving
                                    ? null
                                    : () async {
                                        final (bytes, name) =
                                            await pickImageFile();
                                        if (bytes == null ||
                                            name == null) {
                                          return;
                                        }

                                        setModalState(() {
                                          selectedImageBytes =
                                              bytes;
                                          selectedImageName =
                                              name;
                                        });
                                      },
                                icon: const Icon(
                                  Icons.upload_file_outlined,
                                ),
                                label:
                                    const Text('Pilih Gambar'),
                              ),
                            ),
                            if (selectedImageBytes != null ||
                                (currentImageUrl != null &&
                                    currentImageUrl!
                                        .isNotEmpty)) ...[
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: isSaving
                                    ? null
                                    : () {
                                        setModalState(() {
                                          selectedImageBytes =
                                              null;
                                          selectedImageName =
                                              null;
                                          currentImageUrl =
                                              null;
                                        });
                                      },
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: nameController,
                          textInputAction:
                              TextInputAction.next,
                          inputFormatters:
                              InputValidators
                                  .productNameInputFormatters(),
                          validator: InputValidators
                              .validateProductName,
                          decoration: const InputDecoration(
                            labelText: 'Nama Produk',
                            hintText:
                                'Huruf dan angka boleh, tapi tidak boleh angka semua',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: priceController,
                          keyboardType:
                              TextInputType.number,
                          inputFormatters: [
                            ...InputValidators
                                .priceInputFormatters(),
                            RupiahInputFormatter(),
                          ],
                          textInputAction:
                              TextInputAction.next,
                          validator: (value) =>
                              InputValidators
                                  .validatePositivePrice(
                            value,
                            label: 'Harga jual',
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Harga Jual',
                            hintText:
                                'Contoh: 10000 → 10.000 (maks Rp100.000)',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: costPriceController,
                          keyboardType:
                              TextInputType.number,
                          inputFormatters: [
                            ...InputValidators
                                .priceInputFormatters(),
                            RupiahInputFormatter(),
                          ],
                          textInputAction:
                              TextInputAction.next,
                          validator: (value) {
                            final basicValidation =
                                InputValidators
                                    .validatePositivePrice(
                              value,
                              label: 'Harga modal',
                            );

                            if (basicValidation != null) {
                              return basicValidation;
                            }

                            return InputValidators
                                .validateCostPriceNotGreaterThanPrice(
                              priceValue:
                                  priceController.text,
                              costPriceValue: value,
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Harga Modal',
                            hintText:
                                'Contoh: 8000 → 8.000 (maks Rp100.000)',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: stockController,
                          keyboardType:
                              TextInputType.number,
                          inputFormatters: InputValidators
                              .stockInputFormatters(),
                          textInputAction:
                              TextInputAction.done,
                          validator:
                              InputValidators.validateStock,
                          decoration: const InputDecoration(
                            labelText: 'Stok',
                            hintText:
                                'Hanya angka. Maksimal 3000',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: isSaving
                                    ? null
                                    : () => Navigator.pop(
                                          dialogContext,
                                        ),
                                child:
                                    const Text('Batal'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: isSaving
                                    ? null
                                    : () async {
                                        FocusScope.of(context)
                                            .unfocus();

                                        final isValid =
                                            formKey
                                                    .currentState
                                                    ?.validate() ??
                                                false;
                                        if (!isValid) {
                                          return;
                                        }

                                        final price =
                                            int.parse(
                                          InputValidators
                                              .stripCurrencyFormatting(
                                            priceController
                                                .text,
                                          ),
                                        );

                                        final costPrice =
                                            int.parse(
                                          InputValidators
                                              .stripCurrencyFormatting(
                                            costPriceController
                                                .text,
                                          ),
                                        );

                                        final stock =
                                            int.parse(
                                          stockController.text
                                              .trim(),
                                        );

                                        if (costPrice >
                                            price) {
                                          ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Harga modal tidak boleh lebih besar dari harga jual',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        if (product !=
                                            null) {
                                          final isConfirmed =
                                              await showDialog<
                                                  bool>(
                                            context:
                                                dialogContext,
                                            builder:
                                                (confirmContext) =>
                                                    AlertDialog(
                                              shape:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  24,
                                                ),
                                              ),
                                              title:
                                                  const Text(
                                                'Konfirmasi',
                                              ),
                                              content:
                                                  Text(
                                                'Apakah Anda ingin mengedit produk ${product.name}?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                    confirmContext,
                                                    false,
                                                  ),
                                                  child:
                                                      const Text(
                                                    'Batal',
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed:
                                                      () => Navigator.pop(
                                                    confirmContext,
                                                    true,
                                                  ),
                                                  child:
                                                      const Text(
                                                    'Ya',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (isConfirmed !=
                                              true) {
                                            return;
                                          }
                                        }

                                        setModalState(() {
                                          isSaving = true;
                                        });

                                        try {
                                          String? imageUrl =
                                              currentImageUrl;

                                          if (selectedImageBytes !=
                                                  null &&
                                              selectedImageName !=
                                                  null) {
                                            imageUrl =
                                                await _service
                                                    .uploadProductImageBytes(
                                              bytes:
                                                  selectedImageBytes!,
                                              originalFileName:
                                                  selectedImageName!,
                                            );
                                          }

                                          final normalizedName =
                                              InputValidators
                                                  .normalizeText(
                                            nameController.text,
                                          );

                                          if (product ==
                                              null) {
                                            await _service
                                                .addProduct(
                                              name:
                                                  normalizedName,
                                              price: price,
                                              costPrice:
                                                  costPrice,
                                              stock: stock,
                                              imageUrl:
                                                  imageUrl,
                                            );
                                          } else {
                                            await _service
                                                .updateProduct(
                                              id: product.id,
                                              name:
                                                  normalizedName,
                                              price: price,
                                              costPrice:
                                                  costPrice,
                                              stock: stock,
                                              imageUrl:
                                                  imageUrl,
                                            );
                                          }

                                          if (!mounted) {
                                            return;
                                          }

                                          Navigator.pop(
                                            dialogContext,
                                          );
                                          await fetchProducts();

                                          if (!mounted) {
                                            return;
                                          }

                                          ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                product ==
                                                        null
                                                    ? 'Produk berhasil ditambahkan'
                                                    : 'Data berhasil diupdate',
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          if (!mounted) {
                                            return;
                                          }
                                          ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Gagal menyimpan produk: $e',
                                              ),
                                            ),
                                          );
                                        } finally {
                                          if (dialogContext
                                              .mounted) {
                                            setModalState(() {
                                              isSaving =
                                                  false;
                                            });
                                          }
                                        }
                                      },
                                child: isSaving
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color:
                                              Colors.white,
                                        ),
                                      )
                                    : const Text('Simpan'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> confirmDelete(ProductModel product) async {
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text('Hapus Produk'),
        content: Text(
          'Yakin ingin menghapus ${product.name}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await _service.deleteProduct(product.id);
                await fetchProducts();

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Produk berhasil dihapus'),
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Gagal menghapus produk: $e',
                    ),
                  ),
                );
              }
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Widget _stockBadge(int stock) {
    final color = stock < 15
        ? AppColors.danger
        : AppColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Stok: $stock',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Kelola Produk',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Atur menu, harga, stok, dan tambahkan gambar produk agar lebih menarik.',
            style: TextStyle(
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productImage(ProductModel product) {
    if (product.imageUrl != null &&
        product.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          product.imageUrl!,
          width: 64,
          height: 64,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) {
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color:
                    AppColors.primary.withOpacity(0.12),
                borderRadius:
                    BorderRadius.circular(16),
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
      width: 64,
      height: 64,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          _productImage(product),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Harga Jual: ${CurrencyFormatter.rupiah(product.price)}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Harga Modal: ${CurrencyFormatter.rupiah(product.costPrice)}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                _stockBadge(product.stock),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () =>
                    showProductDialog(
                  product: product,
                ),
                icon: const Icon(
                  Icons.edit_outlined,
                ),
              ),
              IconButton(
                onPressed: () =>
                    confirmDelete(product),
                icon: const Icon(
                  Icons.delete_outline,
                ),
              ),
            ],
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
            'Belum ada produk',
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
        title: const Text('Produk'),
      ),
      floatingActionButton:
          FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => showProductDialog(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchProducts,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(),
            const SizedBox(height: 18),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child:
                      CircularProgressIndicator(),
                ),
              )
            else if (products.isEmpty)
              _emptyState()
            else
              ...products.map(_productCard),
          ],
        ),
      ),
    );
  }
}