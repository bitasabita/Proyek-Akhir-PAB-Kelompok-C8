import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createEmployee({
    required String name,
    required String email,
    required String password,
  }) async {
    final session = _client.auth.currentSession;
    final accessToken = session?.accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Sesi login tidak ditemukan. Silakan login ulang.');
    }

    final response = await _client.functions.invoke(
      'create-employee',
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.status != 200) {
      final data = response.data;

      if (data is Map && data['error'] != null) {
        throw Exception(data['error']);
      }

      throw Exception('Gagal membuat akun karyawan');
    }
  }

  Future<List<Map<String, dynamic>>> getEmployees() async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('role', 'employee')
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }
}