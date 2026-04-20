import 'package:camera/camera.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentProofService {
  final SupabaseClient _client = Supabase.instance.client;

  bool requiresProof(String paymentMethod) {
    final value = paymentMethod.toLowerCase().trim();
    return value == 'qris' || value == 'transfer';
  }

  Future<String> uploadProof({
    required String orderId,
    required XFile imageFile,
  }) async {
    final bytes = await imageFile.readAsBytes();

    final extension = imageFile.path.contains('.')
        ? imageFile.path.split('.').last.toLowerCase()
        : 'jpg';

    final fileName =
        'proof_${DateTime.now().millisecondsSinceEpoch}.$extension';
    final filePath = 'orders/$orderId/$fileName';

    await _client.storage.from('payment-proofs').uploadBinary(
      filePath,
      bytes,
      fileOptions: FileOptions(
        upsert: false,
        contentType: _getContentType(extension),
      ),
    );

    final publicUrl =
        _client.storage.from('payment-proofs').getPublicUrl(filePath);

    return publicUrl;
  }

  Future<void> saveProofToOrder({
    required String orderId,
    required String proofUrl,
  }) async {
    await _client.from('orders').update({
      'payment_proof_url': proofUrl,
      'payment_proof_uploaded_at': DateTime.now().toIso8601String(),
    }).eq('id', orderId);
  }

  String _getContentType(String ext) {
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}