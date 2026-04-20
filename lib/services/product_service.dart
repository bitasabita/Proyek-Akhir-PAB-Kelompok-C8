import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product_model.dart';

class ProductService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<ProductModel>> getProducts() async {
    final response = await _client
        .from('products')
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => ProductModel.fromMap(item))
        .toList();
  }

  Future<String?> uploadProductImageBytes({
    required Uint8List bytes,
    required String originalFileName,
  }) async {
    try {
      final ext = originalFileName.contains('.')
          ? originalFileName.split('.').last.toLowerCase()
          : 'jpg';

      final fileName =
          'product_${DateTime.now().millisecondsSinceEpoch}.$ext';
      final filePath = 'products/$fileName';

      await _client.storage.from('products-images').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
              upsert: false,
              contentType: _getContentType(ext),
            ),
          );

      final publicUrl =
          _client.storage.from('products-images').getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Gagal upload gambar: $e');
    }
  }

  String _getContentType(String ext) {
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      case 'jpeg':
      case 'jpg':
      default:
        return 'image/jpeg';
    }
  }

  Future<void> addProduct({
    required String name,
    required int price,
    required int costPrice,
    required int stock,
    String? imageUrl,
  }) async {
    await _client.from('products').insert({
      'name': name,
      'price': price,
      'cost_price': costPrice,
      'stock': stock,
      'image_url': imageUrl,
    });
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required int price,
    required int costPrice,
    required int stock,
    String? imageUrl,
  }) async {
    await _client.from('products').update({
      'name': name,
      'price': price,
      'cost_price': costPrice,
      'stock': stock,
      'image_url': imageUrl,
    }).eq('id', id);
  }

  Future<void> updateStock({
    required String id,
    required int stock,
  }) async {
    await _client.from('products').update({
      'stock': stock,
    }).eq('id', id);
  }

  Future<void> deleteProduct(String id) async {
    await _client.from('products').delete().eq('id', id);
  }
}